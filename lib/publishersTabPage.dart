import 'package:enyenikitap/models/publisher.dart';
import 'package:enyenikitap/models/publishers.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/profile/memberOpsPage.dart';
import 'package:enyenikitap/publisherListItem.dart';
import 'package:enyenikitap/tools/testValues.dart';
import 'package:provider/provider.dart';

import 'models/member.dart';

class PublishersTabPage extends StatefulWidget {
  @override
  _PublishersTabPageState createState() => _PublishersTabPageState();
}

class _PublishersTabPageState extends State<PublishersTabPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final publishers = Provider.of<Publishers>(context).list;
    final followingPublisherUids =
        Provider.of<MemberRepo>(context).followingPublisherUids;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Yayınevleri",
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.swap_vert),
            onPressed: () {},
          )
          /* Container(
            margin: EdgeInsets.all(10),
            child: OutlineButton(
              child: Text("Giriş"),
              color: Colors.indigo,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemberOpsPage(),
                  ),
                );
              },
            ),
          )*/
        ],
      ),
      body: ListView.builder(
        itemCount: publishers.length,
        itemBuilder: (context, index) {
          bool hasAlert = false;
          followingPublisherUids.forEach((String curPublisherUid) {
            if (curPublisherUid == publishers[index].uid) hasAlert = true;
          });
          return PublisherListItem(publishers[index], hasAlert);
        },
      ),
    );
  }
}
