import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/models/bookCategory.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:flutter/material.dart';

class Book with ChangeNotifier {
  Firestore _firestore;
  String uid;
  String name;
  String cover;
  String author;
  String publisherUid;
  Publisher publisher;
  String bookCategoryUid;
  BookCategory bookCategory;
  bool isFavorite = false;
  //int pageCount;
  // constructor
  Book(
      {@required this.name,
      @required this.cover,
      @required this.author,
      @required this.publisherUid,
      @required this.publisher,
      @required this.uid});
  factory Book.fromDataSource(reqMap, uid) {
    return Book(
        name: reqMap["name"],
        cover: reqMap["cover"],
        author: reqMap["author"],
        publisherUid: reqMap["publisher"],
        publisher: Publisher.withEmptyValues(),
        uid: uid);
  }
  factory Book.withEmptyValues() {
    return Book(
        name: "",
        cover: "",
        author: "",
        publisherUid: "",
        publisher: Publisher.withEmptyValues(),
        uid: "");
  }
  /* getPublisherDetails() async {
    _firestore = Firestore.instance;
    var query = await _firestore
        .collection("publishers")
        .document(this.publisherUid)
        .get();
    if (query.data != null) {
     
      this.publisher = Publisher.fromDataSource(query.data, query.documentID);
    } else {
      print("not");
      this.publisher = Publisher.withDefaultValues();
    }
    notifyListeners();
  } */
}
