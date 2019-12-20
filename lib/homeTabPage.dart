import 'package:enyenikitap/models/book.dart';
import 'package:enyenikitap/models/bookCategories.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/bookWidget.dart';
import 'package:enyenikitap/publisherStoryThumbWidget.dart';
import 'package:enyenikitap/tools/strings.dart';
import 'package:provider/provider.dart';
import 'models/books.dart';
import 'models/publishers.dart';

@immutable
class Message {
  final String title;
  final String body;

  const Message({
    @required this.title,
    @required this.body,
  });
}

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
/*   @override
  Widget build(BuildContext context) => ListView(
        children: messages.map((message) {
          return ListTile(
            title: Text(message.title),
            subtitle: Text(message.body),
          );
        }).toList(),
      ); */

  // fcm vars
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [Message(body: "body", title: "title")];
  // init
  @override
  void initState() {
    super.initState();
    getHomeBooks();
    //fcm
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text(message['notification']['title'].toString()),
                children: <Widget>[
                  Text(
                    "onMessage",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/testcover.png")
                ],
              );
            });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text(message['notification']['title'].toString()),
                children: <Widget>[
                  Text(
                    "onLaunch",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/testcover.png")
                ],
              );
            });
      },
      onResume: (Map<String, dynamic> message) async {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text(message['notification']['title'].toString()),
                children: <Widget>[
                  Text(
                    "onResume",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/testcover.png")
                ],
              );
            });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

// variables
  List<Book> curBooks = [];
  // functions
  getHomeBooks() async {
    curBooks = await Books.getHomeBooks(20);
    setState(() {});
  }
  // build

  @override
  Widget build(BuildContext context) {
    // home -> books
    //final books = Provider.of<Books>(context);
    //books.getHomeBooks(20);
    // home -> publishers
    final publishers = Provider.of<Publishers>(context).list;

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            homePageSection(title: "Yeni Çıkan Kitaplar", books: curBooks),
            Container(
              height: 95,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              alignment: Alignment.center,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                scrollDirection: Axis.horizontal,
                itemCount: publishers.length,
                itemBuilder: (context, index) {
                  return PublisherStorythumWidget(publishers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget homePageSection({title, List<Book> books}) {
    String sectionTitle = title ?? appName;
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              color: Colors.orange[300],
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.orange[400].withOpacity(0.7), width: 2),
                      color: Colors.white.withOpacity(0.95),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(15))),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      sectionTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16
                          //style: MyTextTheme.textSmall(context),
                          ),
                    ),
                  ))),
          Expanded(
            child: Container(
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 1.5),
                itemCount: books.length,
                itemBuilder: (context, index) {
                 // print("b " + books[index].bookCategoryUid.toString());
                  return BookWidget(
                    books[index],
                    showCategoryLabel: true,
                    showDateLabel: true,
                    source: "home",
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
