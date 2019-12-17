import 'package:flutter/material.dart';

class Book {
  String name;
  String cover;
  String author;
  //int pageCount;
  // constructor
  Book({@required this.name, @required this.cover, @required this.author});
  factory Book.fromDataSource(reqMap){
    return Book(
      name: reqMap["name"],
      cover: reqMap["cover"],
      author: reqMap["author"]
    );
  }
}