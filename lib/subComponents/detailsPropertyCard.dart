import 'package:flutter/material.dart';

class DetailsPropertyCard extends StatelessWidget {
  int _index;
  DetailsPropertyCard(this._index);
  @override
  Widget build(BuildContext context) {
    return Card(
      
      margin: EdgeInsets.all(3),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(color: Colors.indigo,child:Container(
             
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: Icon(
              getIcon(),
              size: 48,
              color: Colors.grey.shade800,
            ),
            ))
          ),
          Expanded(
              flex: 2,
              child: Container(
             alignment: Alignment.center,
               color: Colors.white,
                child:Text(
                "Benzin",
                textAlign: TextAlign.center,
              ),
              ))
        ],
      ),
    );
  }
  IconData getIcon(){
    return Icons.local_gas_station;
  }
}
