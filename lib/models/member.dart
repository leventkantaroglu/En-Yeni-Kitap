import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:enyenikitap/models/bookCategory.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LoginSituation { idle, progress, login, logout }

class MemberRepo with ChangeNotifier {
  // properties
  FirebaseAuth _auth;
  Firestore _firestore;
  String uid;
  LoginSituation logined;
  bool registered;
  List<Book> favoriteBooks;
  List<String> followingBookCategoryUids = [];
  List<String> followingPublisherUids = [];
  bool notifications;
  //
  //constructor
  MemberRepo(
      /* {uid,favoriteBooks,followingBookCategories,followingPublisher,enableNotifications}){
    this.uid=uid; */
      ) {
    _auth = FirebaseAuth.instance;
    checkLogin();

    // print("init memberData");
  }
  //
  // methods
  checkLogin() async {
    var curUser = await _auth.currentUser();

    if (curUser == null) {
      logined = LoginSituation.idle;
      favoriteBooks=[];

    } else {
      logined = LoginSituation.login;
      print(curUser.uid);
      this.uid = curUser.uid;
      //_firestore = Firestore.instance;
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
        print("login " + user.user.uid.toString());
        this.uid = user.user.uid;
        getMemberData();
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

  register(username, password) {
    _auth
        .createUserWithEmailAndPassword(email: username, password: password)
        .then((result) {
      registered = true;
      notifyListeners();
    });
  }

  getMemberData() async {
    _firestore = Firestore.instance;
    var snapshot =
        await _firestore.collection("members").document(this.uid).get();
    if (snapshot.data != null) {
      this.uid = snapshot.documentID;
      this.followingPublisherUids = snapshot.data["followingPublishers"] != null
          ? snapshot.data["followingPublishers"].cast<String>()
          : [];
      this.followingBookCategoryUids =
          snapshot.data["followingBookCategories"].cast<String>() ?? [];
      this.notifications = snapshot.data["notifications"] ?? false;
      getFavoriteBooks(snapshot.data);
    } else {
      favoriteBooks = [];
      this.notifications =  false;
    }
    notifyListeners();
  }

  // "favorite" methods

  getFavoriteBooks(reqMapData) async {
    // init list
    favoriteBooks = [];
    if (reqMapData["favoriteBooks"] != null) {
      reqMapData["favoriteBooks"].forEach((curBookUid) async {
        var snapshot =
            await _firestore.collection("books").document(curBookUid).get();
        Book curBook = Book.fromDataSource(snapshot.data, snapshot.documentID);
        favoriteBooks.add(curBook);
      });
    } else {
      favoriteBooks = [];
    }
    notifyListeners();
  }

  addToFavoriteBooks(Book curBook) {
    var alreadyFavorited = favoriteBooks.where((favBook) {
      return favBook.uid == curBook.uid;
    }).toList();
    if (alreadyFavorited.length == 0) {
      favoriteBooks.add(curBook);
      _firestore.collection("members").document(this.uid).setData(
          {"favoriteBooks": favoriteBooks.map((book) => book.uid).toList()},
          merge: true).then((_) {
        //print("updated (added)");
        notifyListeners();
      });
    } else {
      //print("already favorited");
    }
  }

  removeFromFavoriteBooks(Book curBook) {
    var alreadyFavorited = favoriteBooks.where((favBook) {
      return favBook.uid == curBook.uid;
    }).toList();
    favoriteBooks.removeWhere((favBook) {
      return favBook == curBook;
    });

    _firestore.collection("members").document(this.uid).setData(
        {"favoriteBooks": favoriteBooks.map((book) => book.uid).toList()},
        merge: true).then((_) {
      notifyListeners();
    });
  }

  bool isFavorite(curBook) {
    var favorites = favoriteBooks.where((favBook) {
      return favBook.uid == curBook.uid;
    }).toList();
    return (favorites.length == 0) ? false : true;
  }

  // "follow" methods
  follow({type, curUid}) {
    List newList;
    var curField;
    if (type == "bookCategory") {
      curField = "followingBookCategories";
      newList = followingBookCategoryUids.toSet().toList();
    } else if (type == "publisher") {
      curField = "followingPublishers";
      newList = followingPublisherUids.toSet().toList();
    }
    if (!beingFollowed(curUid, type: type)) {
      newList.add(curUid);

      _firestore
          .collection("members")
          .document(this.uid)
          .setData({curField: newList}, merge: true).then((_) {
        switch (curField) {
          case "followingBookCategories":
            followingBookCategoryUids = newList;
            break;
          case "followingPublishers":
            followingPublisherUids = newList;
            break;
          default:
        }
        notifyListeners();
      });
    }
  }

  unfollow({type, curUid}) {
    List newList;
    var curField;
    if (type == "bookCategory") {
      curField = "followingBookCategories";
      newList = followingBookCategoryUids;
    } else if (type == "publisher") {
      curField = "followingPublishers";
      newList = followingPublisherUids;
    }
    if (beingFollowed(curUid, type: type)) {
      newList.removeWhere((listItem) => curUid == listItem);
      newList.join(', ');
      _firestore
          .collection("members")
          .document(this.uid)
          .setData({curField: newList}, merge: true).then((_) {
        print("updated (added)");
        switch (curField) {
          case "bookCategory":
            newList = followingBookCategoryUids.toSet().toList();
            break;
          case "publisher":
            newList = followingPublisherUids.toSet().toList();
            break;
          default:
        }
        notifyListeners();
      });
    }
  }

  bool beingFollowed(curBookUid, {type}) {
    var beingFollowedItems;
    switch (type) {
      case "bookCategory":
        beingFollowedItems = followingBookCategoryUids.where((curUid) {
          return curUid == curBookUid;
        }).toList();
        break;
      case "publisher":
        beingFollowedItems = followingPublisherUids.where((curUid) {
          return curUid == curBookUid;
        }).toList();
        break;
      default:
    }
    bool result = (beingFollowedItems.length == 0) ? false : true;
    return result;
  }

  // notifcation settings
  enableNotifications() {
    _firestore
        .collection("members")
        .document(this.uid)
        .setData({"notifications": true}, merge: true).then((_) {
      notifications = true;
      notifyListeners();
    });
  }

  disableNotifications() {
    _firestore
        .collection("members")
        .document(this.uid)
        .setData({"notifications": false}, merge: true).then((_) {
      notifications = false;
      notifyListeners();
    });
  }
}
