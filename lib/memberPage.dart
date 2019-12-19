import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/bookGridTile.dart';
import 'package:enyenikitap/listOfFollowingData.dart';
import 'package:enyenikitap/models/book.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/helpPage.dart';
import 'package:enyenikitap/tools/strings.dart';
import 'package:provider/provider.dart';

import 'models/member.dart';

class MemberPage extends StatefulWidget {
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  // variables

  List items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteBooks = Provider.of<MemberRepo>(context).favoriteBooks;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appName,
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpPage(),
                ),
              );
            },
          ),
          //
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text(
                        "Yeni Bir Kitap",
                        textAlign: TextAlign.center,
                      ),
                      children: <Widget>[
                        Text(
                          "LEKA Design & Apps",
                          textAlign: TextAlign.center,
                        )
                      ],
                    );
                  });
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Provider.of<MemberRepo>(context).logout();
            },
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 200,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star_border,
                              color: Colors.indigo,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Favorilerim",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 25),
                            child: (favoriteBooks == null)
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : (favoriteBooks.length == 0)
                                    ? Center(
                                        child: Text("Hiç kitap bulunamadı"),
                                      )
                                    : GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 1,
                                                childAspectRatio: 1.5),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: favoriteBooks.length,
                                        itemBuilder: (context, index) {
                                          return BookGridTile(
                                              favoriteBooks[index],source: "member",);
                                        },
                                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                //height: 200,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.settings,
                              color: Colors.indigo,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Ayarlar",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              (Provider.of<MemberRepo>(context).notifications ==
                                      null)
                                  ? SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("Bildirimler"),
                                        /*  ToggleButtons(
                                    isSelected: [true, false],
                                    children: <Widget>[
                                      Text("Açık"),
                                      Text("Kapalı"),
                                    ],
                                    onPressed: (_) {},
                                  ), */
                                        Switch(
                                          value:
                                              Provider.of<MemberRepo>(context)
                                                  .notifications,
                                          onChanged: (selectedValue) {
                                            (selectedValue == true)
                                                ? Provider.of<MemberRepo>(
                                                        context)
                                                    .enableNotifications()
                                                : Provider.of<MemberRepo>(
                                                        context)
                                                    .disableNotifications();
                                          },
                                        )
                                      ],
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              /*  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: OutlineButton(
                                      borderSide:
                                          BorderSide(color: Colors.indigo),
                                      child: Text("Kategoriler"),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return ListOfFollowingData(
                                                  type: "bookCategory");
                                            });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: OutlineButton(
                                      borderSide:
                                          BorderSide(color: Colors.indigo),
                                      child: Text("Yayınevleri"),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return ListOfFollowingData(
                                                  type: "publisher");
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                             */
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showConfirmDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Bildirim alınmasın?"),
            actions: <Widget>[
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text("Geri"),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text("Onay"),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          );
        });
  }
}
