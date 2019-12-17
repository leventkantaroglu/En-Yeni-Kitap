import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/bookWidget.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:enyenikitap/tools/testValues.dart';

class PublisherDetails extends StatefulWidget {
  final Publisher selectedPublisher;
  PublisherDetails(this.selectedPublisher);
  @override
  _PublisherDetailsState createState() => _PublisherDetailsState();
}

class _PublisherDetailsState extends State<PublisherDetails> {
  // variables
  Firestore _firestore=Firestore.instance;
  List<Book> curBooks=[];
  // functions
  void getBooksOfPublisher()async{
    widget.selectedPublisher.bookUids.forEach((curUid)async{
       var query = await _firestore.collection("books").document(curUid).get();
      Book curBook =Book.fromDataSource(query.data);
      setState(() {
        curBooks.add(curBook);
      }); 
    });
  }
  // init
  @override
  void initState() {
    super.initState();
    getBooksOfPublisher();
  }
  // build 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.selectedPublisher.name,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
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
                    border: Border.all(color: Colors.grey.shade400)
                  ),
                  child: Image.network(
                    widget.selectedPublisher.logo,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("Yayınevi Adı"),
                      Text("Yayınevi Logosu"),
                      Text("Yayın evinin kitapları")
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
              itemCount: curBooks.length,
              itemBuilder: (context, index) {
               return BookWidget(curBooks[index],showCategoryLabel: true,showDateLabel: false,);
              },
            ),
          )
        ],
      )),
    );
  }
}
