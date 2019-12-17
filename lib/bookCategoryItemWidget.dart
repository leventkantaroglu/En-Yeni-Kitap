import 'package:flutter/material.dart';
import 'package:enyenikitap/bookCategoryPage.dart';
import 'package:enyenikitap/models/bookCategory.dart';

class BookCategoryItemWidget extends StatelessWidget {
  final BookCategory selectedBookCategory;
  BookCategoryItemWidget(this.selectedBookCategory);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        child: Container(
            child: ListTile(
          /* leading: Icon(
            selectedBookCategory.icon,
            size: 32,
          ), */
          title: Text(
            selectedBookCategory.label,
          ),
          //subtitle: Text("4 adet"),
          trailing: Icon(Icons.notifications_none),
        )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookCategoryPage(selectedBookCategory),
            ),
          );
        },
      ),
    );
  }
}
