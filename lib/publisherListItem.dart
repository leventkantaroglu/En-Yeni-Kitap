import 'package:flutter/material.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:enyenikitap/publisherDetails.dart';

class PublisherListItem extends StatelessWidget {
  final Publisher selectedPublisher;
  bool hasAlert;
  PublisherListItem(this.selectedPublisher,this.hasAlert);
  @override
  Widget build(BuildContext context) {
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
        trailing: Icon(
         hasAlert==true ? Icons.notifications:Icons.notifications_none,
          
          color: hasAlert==true ?Colors.orange:Colors.grey.withOpacity(0.5)
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PublisherDetails(selectedPublisher)),
          );
        },
      ),
    );
  }
}
