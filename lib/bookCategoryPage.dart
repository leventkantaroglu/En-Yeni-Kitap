import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/bookGridTile.dart';
import 'package:enyenikitap/bookWidget.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:enyenikitap/models/member.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/models/bookCategory.dart';
import 'package:provider/provider.dart';

import 'models/books.dart';

class BookCategoryPage extends StatefulWidget {
  final BookCategory selectedCategory;
  BookCategoryPage(this.selectedCategory);
  @override
  _BookCategoryPageState createState() => _BookCategoryPageState();
}

class _BookCategoryPageState extends State<BookCategoryPage> {
  // variables
  List<Book> curBooks = [];
  // functions
  void getBooksOfCategory() async {
    curBooks =
        await Books.getBooksByType("bookCategory", widget.selectedCategory.uid);
    setState(() {});
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
    final beingFollowed = Provider.of<MemberRepo>(context)
        .beingFollowed(widget.selectedCategory.uid, type: "bookCategory");
    final logined = Provider.of<MemberRepo>(context).logined;
    // -> books
    //final books = Provider.of<Books>(context);
    //books.getBooksByType("bookCategory", widget.selectedCategory.uid);
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
                    label: Text(beingFollowed ? "Takipten Çık" : "Takip et"),
                    onPressed: (logined != LoginSituation.login)
                        ? null
                        : () {
                            (beingFollowed)
                                ? Provider.of<MemberRepo>(context).unfollow(
                                    type: "bookCategory",
                                    curUid: widget.selectedCategory.uid)
                                : Provider.of<MemberRepo>(context).follow(
                                    type: "bookCategory",
                                    curUid: widget.selectedCategory.uid);
                          },
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
                  source: "bookCategory",
                );
              },
            )
          ],
        ));
  }
}
