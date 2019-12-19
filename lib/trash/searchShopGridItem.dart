/* import 'package:flutter/material.dart';

class SearchShopGridItem extends StatelessWidget {
  Map _cityMap;
  SearchShopGridItem(this._cityMap);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: (_cityMap["adCount"] > 0) ? Colors.white : Colors.grey[100],
        margin: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
      child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Text(
                      _cityMap["code"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        color: (_cityMap["adCount"] > 0)
                            ? Colors.black
                            : Colors.grey[500],
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Text(_cityMap["name"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: (_cityMap["adCount"] > 0)
                            ? Colors.black
                            : Colors.grey[500],
                      )),
                ),
              ],
            )),
            
            splashColor: (_cityMap["adCount"] > 0) ?Colors.green.shade300:Colors.grey[300],
            onTap: () {},
            borderRadius: BorderRadius.circular(15),
      ),
      
    );
  }
}
 */