/* import 'package:flutter/material.dart';

class MembershipTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              
                //decoration: BoxDecoration(color: Colors.orange.shade300),
                children: [
                  Container(
                    color: Colors.grey.shade50,
                    child: Text("\n\n"),
                    alignment: Alignment.center,
                  ),
                  Container(color:Colors.orange,child: tableTextItem("Standart\nÜyelik", isBold: true)),
                  Container(color:Colors.orange,child: tableTextItem("Galeri\nÜyelik", isBold: true)),
                  Container(color:Colors.orange,child: tableTextItem("Özel\nÜyelik", isBold: true)),
                ]),
            TableRow(children: [
              tableTextItem("Fiyat"),
              tableTextItem("Ücretsiz", isBold: true),
              tableTextItem("Aylık 5 TL"),
              tableTextItem("Aylık 10 TL"),
            ]),
            TableRow(
                decoration: BoxDecoration(color: Colors.grey.shade100),
                children: [
                  tableTextItem("İlan Sayısı"),
                  tableTextItem("2 adet"),
                  tableTextItem("5 adet"),
                  tableTextItem("15 adet"),
                ]),
            TableRow(children: [
              tableTextItem("İlan Süresi"),
              tableTextItem("30 gün"),
              tableTextItem("60 gün"),
              tableTextItem("60 gün"),
            ]),
            TableRow(
                decoration: BoxDecoration(color: Colors.grey.shade100),
                children: [
                  tableTextItem("Promosyon Ürünleri"),
                  tableTextItem(""),
                  tableTextItem(""),
                  tableIconItem(),
                ]),
            TableRow(children: [
              tableTextItem(""),
              tableButtonItem("Üye Ol"),
              tableButtonItem("Başvur"),
              tableButtonItem("Başvur"),
            ])
          ],
        ));
  }

  Widget tableButtonItem(reqText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        color: (reqText == "Üye Ol") ? Colors.green.shade600 : Colors.indigo,
        child: Text(
          reqText,
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget tableIconItem() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.check));
  }

  Widget tableTextItem(text, {isBold}) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: (isBold == true) ? FontWeight.w600 : FontWeight.w400,
            // color: Colors.white
          ),
        ));
  }
}
 */