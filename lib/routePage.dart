import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyenikitap/models/member.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/homeTabPage.dart';
import 'package:enyenikitap/publishersTabPage.dart';
import 'package:enyenikitap/searchTabPage.dart';
import 'package:enyenikitap/tabNavigator.dart';
import 'customBottomNavigationBar.dart';

enum TabItem { home, search, publishers, member }

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  // variables
  TabItem _currentTab = TabItem.home;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.publishers: GlobalKey<NavigatorState>(),
    TabItem.member: GlobalKey<NavigatorState>(),
  };
  void _selectTab(TabItem _tabItem) {
    setState(() {
      _currentTab = _tabItem;
    });
  }

  var firestore = Firestore.instance;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getMemberDataFromDataSource("MoY6FS1eqr36vVJDRNZC");

  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: Scaffold(
          backgroundColor: Colors.orange.shade200,
          body: SafeArea(
            top: true,
            child: Stack(
              children: <Widget>[
                _buildOffstageNavigator(TabItem.home),
                _buildOffstageNavigator(TabItem.search),
                _buildOffstageNavigator(TabItem.publishers),
                _buildOffstageNavigator(TabItem.member),
              ],
            ),
          ),
          bottomNavigationBar: AppBottomNavigationBar(
            currentTab: _currentTab,
            onSelectTab: _selectTab,
          )),
    );
  }

  Widget _buildOffstageNavigator(TabItem _tabItem) {
    return Offstage(
        offstage: _currentTab != _tabItem,
        child: TabNavigator(
          navigatorKey: navigatorKeys[_tabItem],
          tabItem: _tabItem,
        ));
  }
}
