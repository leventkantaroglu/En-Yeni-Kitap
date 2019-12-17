import 'package:enyenikitap/models/book.dart';
import 'package:flutter/material.dart';

class BookGridTile extends StatefulWidget {
  final Book curBook;
  BookGridTile(this.curBook);
  @override
  _BookGridTileState createState() => _BookGridTileState();
}

class _BookGridTileState extends State<BookGridTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                offset: Offset(4, -3),
                color: Colors.grey.shade600)
          ],
        ),
        child: Image.network(
          widget.curBook.cover,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
