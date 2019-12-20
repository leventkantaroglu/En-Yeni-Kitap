import 'package:enyenikitap/models/bookCategory.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/bookDetailsPage.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:provider/provider.dart';

import 'models/bookCategories.dart';

class BookWidget extends StatelessWidget {
  final Book selectedBook;
  final bool showCategoryLabel;
  final bool showDateLabel;
  final String source;
  BookWidget(this.selectedBook,
      {@required this.showCategoryLabel,
      @required this.showDateLabel,
      @required this.source});

  // functions
  getBookCategoryDetails(context) {
    selectedBook.bookCategory = Provider.of<BookCategories>(context)
        .getBookCategoryFromUid(selectedBook.bookCategoryUid);
  }

  

  @override
  Widget build(BuildContext context) {
    //print("- "+widget.selectedBook.bookCategoryUid);
    getBookCategoryDetails(context);

    //print("c " + widget.selectedBook.bookCategory.label.toString());

    return Card(
      margin: EdgeInsets.only(top: 3, bottom: 15, left: 3, right: 3),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
      child: Container(
        //color: Colors.white,
        decoration: BoxDecoration(
          /* ß */
          image: DecorationImage(
              fit: BoxFit.fill, image: new NetworkImage(selectedBook.cover)),
          boxShadow: [
            new BoxShadow(
              color: Colors.white,
              offset: Offset(1, 1),
              // blurRadius: 1,
            )
          ],
        ),
        //padding: EdgeInsets.all(1),
        //margin: EdgeInsets.all(5),
        //color: Colors.white, //teal[50],
        child: InkWell(
          child: Stack(
            children: <Widget>[
              Visibility(
                visible: this.showDateLabel,
                child: Align(
                  alignment: Alignment(1, 0.95),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.orange.shade700,
                      child: Text(
                        this.selectedBook.publishDateText,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: this.showCategoryLabel,
                child: Align(
                  alignment: Alignment(-0.95, -1),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.orange.shade700,
                      child: Text(
                        this.selectedBook.bookCategory.label,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailsPage(
                  this.selectedBook,
                  source: this.source,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
