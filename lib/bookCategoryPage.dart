import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/bookGridTile.dart';
import 'package:enyenikitap/bookWidget.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/models/bookCategory.dart';

class BookCategoryPage extends StatefulWidget {
  final BookCategory selectedCategory;
  BookCategoryPage(this.selectedCategory);
  @override
  _BookCategoryPageState createState() => _BookCategoryPageState();
}

class _BookCategoryPageState extends State<BookCategoryPage> {
  // variables
  Firestore _firestore = Firestore.instance;
  List<Book> curBooks = [];
  // functions
  void getBooksOfCategory() async {
    widget.selectedCategory.bookUids.forEach((curUid) async {
      var query = await _firestore.collection("books").document(curUid).get();
      //print(query.documentID);
      Book curBook = Book.fromDataSource(query.data);
      setState(() {
        curBooks.add(curBook);
      });
    });
  }

  // init
  @override
  void initState() {
    super.initState();
    getBooksOfCategory();
  }

  // build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.selectedCategory.label,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text("\nKategori Resmi\n"),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.notifications_none),
                    label: Text("Bildirim Al"),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.7,
              ),
              itemCount: curBooks.length,
              itemBuilder: (context, index) {
                return BookWidget(
                  curBooks[index],
                  showCategoryLabel: false,
                  showDateLabel: false,
                );
              },
            )
          ],
        ));
  }
}
