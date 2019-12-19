import 'package:enyenikitap/bookDetailsPage.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:flutter/material.dart';

class BookGridTile extends StatefulWidget {
  final Book curBook;
  final String source;
  BookGridTile(this.curBook,{@required this.source});
  @override
  _BookGridTileState createState() => _BookGridTileState();
}

class _BookGridTileState extends State<BookGridTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          child: Container(
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
      ),
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsPage(widget.curBook,source: widget.source,),
            ),
          );
      },
    );
  }
}
