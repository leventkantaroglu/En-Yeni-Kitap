import 'package:enyenikitap/models/book.dart';
import 'package:flutter/material.dart';

class BookListTile extends StatefulWidget {
  final Book curBook;
  BookListTile(this.curBook);
  @override
  _BookListTileState createState() => _BookListTileState();
}

class _BookListTileState extends State<BookListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 100,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 3,
                offset: Offset(4, -3),
                color: Colors.grey.shade600)
          ]),
          child: Image.asset(
            widget.curBook.cover,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.curBook.name),
                Text("Publisher"),
              ],
            ),
          ),
        ),
        PopupMenuButton(
          //  icon: Icon(Icons.recei),

          itemBuilder: (context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                child: Text("data"),
              ),
              PopupMenuItem(
                child: Text("data"),
              )
            ];
          },
        )
      ]),
    );
  }
}
