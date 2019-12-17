import 'package:flutter/material.dart';

class BookCategory{
  String label;
  IconData icon;
  List bookUids;
  BookCategory({@required this.label,@required this.icon,this.bookUids});
   factory BookCategory.fromDataSource(reqMap){
    return BookCategory(
      label: reqMap["label"],
      icon: reqMap["icon"],
      bookUids:reqMap["bookUids"]??[]
    );
  }
}

