import 'package:flutter/material.dart';
import 'package:enyenikitap/bookCategoryPage.dart';
import 'package:enyenikitap/models/bookCategory.dart';
import 'package:provider/provider.dart';

import 'models/member.dart';

class BookCategoryItemWidget extends StatelessWidget {
  final BookCategory selectedBookCategory;
  BookCategoryItemWidget(this.selectedBookCategory);

  @override
  Widget build(BuildContext context) {
    final beingFollowed = Provider.of<MemberRepo>(context)
        .beingFollowed(selectedBookCategory.uid, type: "bookCategory");
    final logined = Provider.of<MemberRepo>(context).logined;

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
          trailing: (logined != LoginSituation.login)
              ? null
              : Icon(
                  (beingFollowed)
                      ? Icons.notifications
                      : Icons.notifications_none,
                  color: (beingFollowed)
                      ? Colors.deepOrange.shade300
                      : Colors.grey.withOpacity(0.5),
                ),
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
