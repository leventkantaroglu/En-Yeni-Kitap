import 'package:enyenikitap/models/member.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:provider/provider.dart';

import 'models/books.dart';

class BookDetailsPage extends StatefulWidget {
  final Book selectedBook;
  final String source;
  BookDetailsPage(this.selectedBook, {@required this.source});
  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final isFavorite =
        Provider.of<MemberRepo>(context).isFavorite(widget.selectedBook);

    final books = Provider.of<Books>(context);
    books.getPublisherDetails(uid: widget.selectedBook.publisherUid,source: widget.source);
    Book curBook;
    switch (widget.source) {
      case "home":
        curBook=books.currentHomeTabBook;
        break;
        case "bookCategory":
        curBook=books.currentBookCategoryTabBook;
        break;
        case "publisher":
        curBook=books.currentPublisherTabBook;
        break;
        case "member":
        curBook=books.currentMemberTabBook;
        break;
      default:
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.selectedBook.name,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon((isFavorite) ? Icons.star : Icons.star_border),
            onPressed: () {
              (isFavorite)
                  ? Provider.of<MemberRepo>(context)
                      .removeFromFavoriteBooks(widget.selectedBook)
                  : Provider.of<MemberRepo>(context)
                      .addToFavoriteBooks(widget.selectedBook);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(7),
              child: Text(
                "Yazar: " + widget.selectedBook.author,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              ),
            ),
            Container(
              padding: EdgeInsets.all(7),
              child: Text(
                "Yayınevi: " + curBook.publisher.name,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              ),
            ),
            Container(
              padding: EdgeInsets.all(7),
              child: Text(
                "Sayfa Sayısı: ",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  // height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    //               borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
                  ),
                  child: Image.network(
                    widget.selectedBook.cover,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
