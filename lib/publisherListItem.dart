import 'package:enyenikitap/models/member.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:enyenikitap/publisherDetails.dart';
import 'package:provider/provider.dart';

class PublisherListItem extends StatelessWidget {
  final Publisher selectedPublisher;
  
  PublisherListItem(this.selectedPublisher);
  @override
  Widget build(BuildContext context) {
     final beingFollowed = Provider.of<MemberRepo>(context)
        .beingFollowed(selectedPublisher.uid, type: "publisher");
    
    final logined = Provider.of<MemberRepo>(context).logined;
    return Card(
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: new BoxDecoration(
            border: Border.all(color: Colors.grey),
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(selectedPublisher.logo)),
          ),
          //child:Image.asset(selectedPublisher.logo),
        ),
        title: Text(selectedPublisher.name),
        // subtitle: Text("Yeni Kitap: 14"),
        trailing: (logined != LoginSituation.login)
            ? null
            : Icon(
                beingFollowed == true
                    ? Icons.notifications
                    : Icons.notifications_none,
                color: beingFollowed == true
                    ? Colors.orange
                    : Colors.grey.withOpacity(0.5)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PublisherDetails(selectedPublisher,source: "publisher",)),
          );
        },
      ),
    );
  }
}
