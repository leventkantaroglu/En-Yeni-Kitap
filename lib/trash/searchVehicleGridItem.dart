/* import 'package:flutter/material.dart';
import 'package:enyenikitap/mainComponents/customComponents.dart';
import 'package:enyenikitap/mainComponents/searchVehicle.dart';
import 'package:enyenikitap/search/searchClass.dart';

import 'package:enyenikitap/tools/infoCenter.dart';

class SearchVehicleGridItem extends StatelessWidget {
  Map _reqMap;
  Search _curSearch;
  SearchVehicleGridItem({items,searchObject}){
    this._reqMap=items;
    this._curSearch=searchObject;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (_reqMap["adCount"] > 0) ? Colors.white : Colors.grey[100],
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Image.asset(_reqMap["image"]),
                ),
                Expanded(
                  flex: 2,
                  child: Text(_reqMap["name"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: (_reqMap["adCount"] > 0)
                            ? Colors.black
                            : Colors.grey[500],
                      )),
                ),
              ],
            )),
        splashColor: (_reqMap["adCount"] > 0)
            ? Colors.green.shade300
            : Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          print("grid press to next"+_curSearch.nextCriteria);
          Search nextSearch;
          switch (_curSearch.nextCriteria) {
            case "brand":
              nextSearch=Search.criteriaIsBrand();
              break;
            default:
          }
          
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SearchVehicle(criterias: [],)
          ));
         /* Navigator.push(context,MaterialPageRoute(
              
              builder:(context){

                  
                  Search nextSearch=Search.criteriaIsCategory();
                  return SearchVehicle(
                    topSearch
                  );
              }));*/

        },
      ),
    );
  }
}
 */