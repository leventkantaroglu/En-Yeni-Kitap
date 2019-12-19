import 'package:flutter/material.dart';

class BookCategory {
  //
  // properties
  String uid;
  String label;
  String image;
  List bookUids;
  // default values
  static String defaultLabel = "Label Error";
  static String defaultImage = "Image Error";

  //
  // constructor
  BookCategory(
      { this.uid,
      @required this.label,
      @required this.image,
      this.bookUids});
  factory BookCategory.fromDataSource(reqMap, reqUid) {
    return BookCategory(
        uid: reqUid,
        label: reqMap["label"] ?? defaultLabel,
        image: reqMap["image"] ?? defaultImage,
        bookUids: reqMap["bookUids"] ?? []);
  }
  factory BookCategory.withDefaultValues() {
    return BookCategory(
      label: defaultLabel,
      image: defaultImage, // !!! default image
    );
  }
  factory BookCategory.withEmptyValues() {
    return BookCategory(
      label: "",
      image: defaultImage, // !!! default image
    );
  }
}
