import 'package:enyenikitap/models/book.dart';
import 'package:enyenikitap/models/bookCategories.dart';
import 'package:enyenikitap/models/books.dart';
import 'package:enyenikitap/models/member.dart';
import 'package:enyenikitap/models/publisher.dart';
import 'package:enyenikitap/models/publishers.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/routePage.dart';
import 'package:enyenikitap/tools/strings.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          textTheme: TextTheme(
              title: TextStyle(
                  color: Colors.indigo,
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.orange.shade800,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Books()),
          ChangeNotifierProvider(create: (_) => Publishers()),
          ChangeNotifierProvider(create: (_) => BookCategories()),
          ChangeNotifierProvider(create: (_) => MemberRepo()),
        ],
        child: RoutePage(),
      ),
    );
  }
}
