import 'package:flutter/material.dart';

class PublisherManagementPage extends StatefulWidget {
  @override
  _PublisherManagementPageState createState() => _PublisherManagementPageState();
}

class _PublisherManagementPageState extends State<PublisherManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yayınevi Adı",style: TextStyle(color: Colors.indigo),),),
          body: Column(
        // appBar: CustomComponents.customAppBar(context),
        // bottomNavigationBar: CustomComponents.customcustomBottomNavigationBar(context,2),
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          
          Expanded(
            flex: 1,
            child: Text("Kitaplar",textAlign: TextAlign.center,),
          ),
          // Yeni Bir Kitap
          // En Yeni Kitap
          
        ],
      ),
    );
  }

 
  
}
