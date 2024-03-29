import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/models/bookCategory.dart';
import 'package:flutter/material.dart';

class BookCategories with ChangeNotifier {
  Firestore _firestore;
  List<BookCategory> list = [];
  BookCategories() {
    //this.list=list;
    this._firestore = Firestore.instance;
    getBookCategoriesDataFromDataSource();
    //print("init bookCategories");
  }

  getBookCategoriesDataFromDataSource() async {
    var snapshots = await _firestore
        .collection("bookCategories")
        .orderBy("label")
        .getDocuments();
    snapshots.documents.forEach((snapshot) {
      BookCategory curBookCategory =
          BookCategory.fromDataSource(snapshot.data, snapshot.documentID);
      this.list.add(curBookCategory);
    });
    notifyListeners();
  }

  getBookCategoryFromUid(uid) {
    BookCategory curBookCategory=BookCategory.withEmptyValues();
    list.forEach((BookCategory bookCategoryItem) {
      if (uid == bookCategoryItem.uid) {
        curBookCategory = bookCategoryItem;
      }
    });
    return curBookCategory;
  }
}
