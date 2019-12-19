import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/bookWidget.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:provider/provider.dart';

import 'models/books.dart';
import 'models/member.dart';

class PublisherDetails extends StatefulWidget {
  final Publisher selectedPublisher;
  final String source;
  PublisherDetails(this.selectedPublisher,{@required this.source});
  @override
  _PublisherDetailsState createState() => _PublisherDetailsState();
}

class _PublisherDetailsState extends State<PublisherDetails> {
  // variables
  
  

  // init
  @override
  void initState() {
    super.initState();
    //getBooksOfPublisher();
  }

  // build
  @override
  Widget build(BuildContext context) {
    final beingFollowed = Provider.of<MemberRepo>(context)
        .beingFollowed(widget.selectedPublisher.uid, type: "publisher");
    final logined = Provider.of<MemberRepo>(context).logined;
    // -> books
    final books = Provider.of<Books>(context);
    books.getBooksByType("publisher", widget.selectedPublisher.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.selectedPublisher.name,
        ),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Container(
          //padding: EdgeInsets.all(25),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(25),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400)),
                  child: Image.network(
                    widget.selectedPublisher.logo,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      (logined != LoginSituation.login)
                          ? SizedBox()
                          : FlatButton.icon(
                              icon: Icon(Icons.notifications_none),
                              label: Text(
                                  beingFollowed ? "Takipten Çık" : "Takip et"),
                              onPressed: () {
                                (beingFollowed)
                                    ? Provider.of<MemberRepo>(context).unfollow(
                                        type: "publisher",
                                        curUid: widget.selectedPublisher.uid)
                                    : Provider.of<MemberRepo>(context).follow(
                                        type: "publisher",
                                        curUid: widget.selectedPublisher.uid);
                              },
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.5, crossAxisCount: 1),
              itemCount: books.publisherBooks.length,
              itemBuilder: (context, index) {
                return BookWidget(
                  books.publisherBooks[index],
                  showCategoryLabel: true,
                  showDateLabel: false,
                  source: widget.source,
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
