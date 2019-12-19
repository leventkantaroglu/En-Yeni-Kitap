import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/bookCategoryItemWidget.dart';
import 'package:provider/provider.dart';
import 'models/bookCategories.dart';

class BookCategoriesTabPage extends StatefulWidget {
  @override
  _BookCategoriesTabPageState createState() => _BookCategoriesTabPageState();
}

class _BookCategoriesTabPageState extends State<BookCategoriesTabPage>
{
 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookCategories = Provider.of<BookCategories>(context).list;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kitap Kategorileri",
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
