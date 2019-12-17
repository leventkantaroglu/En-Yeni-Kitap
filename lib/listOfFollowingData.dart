import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListOfFollowingData extends StatefulWidget {
  final String type;
  ListOfFollowingData({@required this.type});
  @override
  _ListOfFollowingDataState createState() => _ListOfFollowingDataState();
}

class _ListOfFollowingDataState extends State<ListOfFollowingData> {
 

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    // get data according to type of list
  
  }
/* 
  getItemsFromDataSource() async {
    var snapshot = await firestore
        .collection("members")
        .document("MoY6FS1eqr36vVJDRNZC")
        .get();

    switch (widget.type) {
      case "bookCategory":
        items = snapshot.data["followingBookCategories"];
        break;
      case "publisher":
        items = snapshot.data["followingPublishers"];
        break;
      default:
    }
    setState(() {
      
    });
  }
 */
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(10),
      color: Colors.indigo,
      child: ListView.builder(
        itemCount: 1,//items.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            child: ListTile(
              title: Text("items[index]"),
              trailing: Icon(Icons.remove_circle_outline),
            ),
          );
        },
      ),
    );
  }
}
