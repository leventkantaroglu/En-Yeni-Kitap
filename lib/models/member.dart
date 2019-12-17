import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:enyenikitap/models/bookCategory.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LoginSituation { idle, progress, login, logout }

class MemberRepo with ChangeNotifier {

  FirebaseAuth _auth;
  Firestore _firestore;
  String uid = "MoY6FS1eqr36vVJDRNZC";
  LoginSituation logined;
  bool registered;
  List<Book> favoriteBooks;
  List<String> followingBookCategoryUids = [];
  List<String> followingPublisherUids = [];
  bool enableNotifications;
  MemberRepo(
      /* {uid,favoriteBooks,followingBookCategories,followingPublisher,enableNotifications}){
    this.uid=uid; */
      ) {
   
    _auth = FirebaseAuth.instance;
    checkLogin();
    //loginListener();
    // print("init memberData");
  }
  checkLogin() async {
    var curUser = await _auth.currentUser();

    if (curUser == null) {
      logined = LoginSituation.idle;
    } else {
      logined = LoginSituation.login;
      _firestore = Firestore.instance;
      getMemberData();
    }
    notifyListeners();
  }

 /*  loginListener() {
    _auth.onAuthStateChanged.listen((curUser) {
      //print(curUser.toString());
      if (curUser != null) {
        logined = LoginSituation.logout;
      } else {
        logined = LoginSituation.login;
      }
     // notifyListeners();
    });
  } */

  login(username, password) {
    if (logined != LoginSituation.login) {
      _auth
          .signInWithEmailAndPassword(email: username, password: password)
          .then((user) {
        logined = LoginSituation.login;
        print("login");
        notifyListeners();
      }).catchError((err) {
        print("er " + err.toString());
      });
    } else {
      print("already logined");
    }
  }

  logout() {
    print("logout");
    logined = LoginSituation.progress;
    _auth.signOut().then((_) {
      logined = LoginSituation.logout;
      notifyListeners();
    });
  }
  register(username, password){
    _auth.createUserWithEmailAndPassword(email: username,password: password).then((result){
       registered=true;
       notifyListeners();

    });
  }

  getMemberData() async {
    var snapshot = await _firestore
        .collection("members")
        .document("MoY6FS1eqr36vVJDRNZC")// !!!
        .get();
    this.uid = snapshot.documentID;
    this.followingPublisherUids =
        snapshot.data["followingPublishers"].cast<String>();
    getFavoriteBooks();
    //print(snapshot.data.toString());
  }

  getFavoriteBooks() async {
    // init list
    favoriteBooks = [];
    var snapshots = await _firestore
        .collection("books")
        .where("favoriteUsers", arrayContains: this.uid)
        .getDocuments();
    snapshots.documents.forEach((snapshot) {
      Book curBook = Book.fromDataSource(snapshot.data);
      favoriteBooks.add(curBook);
    });
    notifyListeners();
  }
  addToFavoriteBooks(Book curBook){
    print(curBook.name);
    // !!! update on database
  }
}
