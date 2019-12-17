import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/bookCategoryItemWidget.dart';
import 'package:enyenikitap/models/bookCategory.dart';
import 'package:enyenikitap/publisherDetails.dart';
import 'package:enyenikitap/tools/testValues.dart';
import 'package:provider/provider.dart';

import 'models/bookCategories.dart';
import 'models/publishers.dart';

class SearchTabPage extends StatefulWidget {
  @override
  _SearchTabPageState createState() => _SearchTabPageState();
}

class _SearchTabPageState extends State<SearchTabPage>
   // with SingleTickerProviderStateMixin 
   {
     
  String vehicleCategoryOptionsLevel = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookCategories=Provider.of<BookCategories>(context).list;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kategoriler",
         ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: bookCategories.length,
        itemBuilder: (context, index) {
          return BookCategoryItemWidget(bookCategories[index]);
        }, 
      ),
    );
  }
}
