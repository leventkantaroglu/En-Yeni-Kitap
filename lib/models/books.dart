import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Books with ChangeNotifier{
  Firestore _firestore;
  List<Book> list=[];
  Books(){
    //this.list=list;
    this._firestore=Firestore.instance;
    getBooksDataFromDataSource();
    //print("init Books");
  }

   getBooksDataFromDataSource() async {
     
    var snapshots = await _firestore.collection("books")//.limit(1)
    .getDocuments();
    snapshots.documents.forEach((snapshot) {
      Book curBook = Book.fromDataSource(snapshot.data);
      this.list.add(curBook);
    });
    notifyListeners();
  }
}