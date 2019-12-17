import 'package:flutter/material.dart';

class Publisher {
  String uid;
  String name;
  String logo;
  List bookUids;
  Publisher({@required this.name, this.logo,this.uid,this.bookUids});
  factory Publisher.fromDataSource(reqMap,reqUid){
    return Publisher(
      name: reqMap["name"],
      logo: reqMap["logo"],
      bookUids: reqMap["books"]??[],
      uid: reqUid
    );
  }
}
