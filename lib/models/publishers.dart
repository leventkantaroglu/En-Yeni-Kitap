import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/configuration.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Publishers with ChangeNotifier {
  Firestore _firestore;
  List<Publisher> list = [];
  Publishers() {
    //this.list=list;
    this._firestore = Firestore.instance;
    getPublishersDataFromDataSource();
    //print("init publishers");
  }

  getPublishersDataFromDataSource() async {
    var snapshots = await _firestore.collection("publishers").orderBy("name").getDocuments();
    snapshots.documents.forEach((snapshot) {
      Publisher curPublisher =
          Publisher.fromDataSource(snapshot.data, snapshot.documentID);
      this.list.add(curPublisher);
    });
    notifyListeners();
  }
}
