import 'package:enyenikitap/models/member.dart';
import 'package:enyenikitap/profile/memberRegisterForm.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/profile/publisherManagementPage.dart';
import 'package:provider/provider.dart';

class MemberLoginForm extends StatefulWidget {
  @override
  _MemberLoginFormState createState() => _MemberLoginFormState();
}

class _MemberLoginFormState extends State<MemberLoginForm> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController nameController =
      TextEditingController(text: "kaiserofthenight@dr.com");
  TextEditingController passwordController =
      TextEditingController(text: "123654");
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
          body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Giriş Ekranı",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                controller: nameController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                controller: passwordController,
                obscureText: true,
              ),
              FlatButton(
                child: Text("Giriş"),
                onPressed: () {
                  Provider.of<MemberRepo>(context)
                      .login(nameController.text, passwordController.text);
                  /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PublisherManagementPage(),
                    ),
                  ); */
                },
              ),
              Divider(),
              FlatButton(
                child: Text("Kayıt"),
                onPressed: () {
                  /*   Provider.of<MemberRepo>(context)
                      .login(nameController.text, passwordController.text);
                  */
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemberRegisterForm(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
