import 'package:flutter/material.dart';

class Publisher {
  //
  // variables
  String uid;
  String name;
  String logo;
  //List bookUids;
  // Default values
  static String defaultName = "Name Error";
  static String defaultLogo = "Logo Error"; // !!!
  //
  // contructor
  Publisher({@required this.name, this.logo, this.uid
      //,this.bookUids
      });
  factory Publisher.fromDataSource(reqMap, reqUid) {
    return Publisher(
        name: reqMap["name"] ?? defaultName,
        logo: reqMap["logo"] ?? defaultLogo, // !!! default image
        // bookUids: reqMap["bookUids"]??[],
        uid: reqUid);
  }
  factory Publisher.withDefaultValues() {
    return Publisher(
      name: defaultName,
      logo: defaultLogo, // !!! default image
    );
  }
  factory Publisher.withEmptyValues() {
    return Publisher(
      name: "",
      logo: defaultLogo, // !!! default image
    );
  }
}
