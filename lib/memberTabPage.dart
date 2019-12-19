import 'package:enyenikitap/memberPage.dart';
import 'package:enyenikitap/profile/memberLoginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/member.dart';

class MemberTabPage extends StatefulWidget {
  @override
  _MemberTabPageState createState() => _MemberTabPageState();
}

class _MemberTabPageState extends State<MemberTabPage> {
  @override
  Widget build(BuildContext context) {
    var login = Provider.of<MemberRepo>(context).logined;
    //Provider.of<MemberRepo>(context).loginListener();
    switch (login) {
      case LoginSituation.idle:
      case LoginSituation.logout:
        return MemberLoginPage();
      case LoginSituation.progress:
        return Center(
          child: CircularProgressIndicator(),
        );
      case LoginSituation.login:
        return MemberPage();
      default:
        return Center(
          child: Text("Error"),
        ); 
    }
  }
}
