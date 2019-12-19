import 'package:enyenikitap/memberTabPage.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/homeTabPage.dart';
import 'package:enyenikitap/publishersTabPage.dart';
import 'package:enyenikitap/routePage.dart';
import 'package:enyenikitap/memberPage.dart';

import 'bookCategoriesTabPage.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/vehicleDetails';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({@required this.navigatorKey, @required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                routeBuilders[TabNavigatorRoutes.detail](context)));
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    switch (tabItem) {
      case TabItem.home:
        return {
          TabNavigatorRoutes.root: (context) => HomeTabPage(),
        };
      case TabItem.bookCategories:
        return {
          TabNavigatorRoutes.root: (context) => BookCategoriesTabPage(),
        };
      case TabItem.publishers:
        return {
          TabNavigatorRoutes.root: (context) => PublishersTabPage(),
        };
      case TabItem.member:
        return {
          TabNavigatorRoutes.root: (context) => MemberTabPage(),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
        key: navigatorKey,
        initialRoute: TabNavigatorRoutes.root,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        });
  }
}
