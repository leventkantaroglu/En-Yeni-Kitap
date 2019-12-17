import 'package:flutter/material.dart';
import 'package:enyenikitap/routePage.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  AppBottomNavigationBar({this.currentTab, this.onSelectTab});
  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var barColor= Colors.orange.shade700;
    return BottomNavigationBar(
      //backgroundColor: Colors.green,

      selectedItemColor: Colors.yellowAccent.shade100,
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          backgroundColor: barColor,
          icon: Icon(Icons.home),
          title: Text("En Yeniler"),
        ),
        BottomNavigationBarItem(
          backgroundColor:  barColor,
          icon: Icon(Icons.menu),
          title: Text("Kategoriler"),
        ),
        BottomNavigationBarItem(
          backgroundColor:  barColor,
          icon: Icon(Icons.book),
          title: Text("Yayınevleri"),
        ),
        BottomNavigationBarItem(
          backgroundColor:  barColor,
          icon: Icon(Icons.person),
          title: Text("Sayfam"),
        ),
      ],
      onTap: (index) {
        widget.onSelectTab(
          TabItem.values[index],
        );
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
