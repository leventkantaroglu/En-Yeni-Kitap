import 'package:flutter/material.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:enyenikitap/publisherDetails.dart';

class PublisherStorythumWidget extends StatelessWidget {
  final Publisher selectedPublisher;
  PublisherStorythumWidget(this.selectedPublisher);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              decoration: new BoxDecoration(
                border: Border.all(),
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(selectedPublisher.logo)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
              ),
            ),
            Text(
              selectedPublisher.name,
              style: TextStyle(fontSize: 9),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PublisherDetails(selectedPublisher,source:"home" ),
        ),
      ),
    );
  }
}
