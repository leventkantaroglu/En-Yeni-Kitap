import 'package:enyenikitap/models/member.dart';
import 'package:enyenikitap/profile/memberRegisterForm.dart';
import 'package:flutter/material.dart';
import 'package:enyenikitap/profile/publisherManagementPage.dart';
import 'package:provider/provider.dart';

class MemberLoginPage extends StatefulWidget {
  @override
  _MemberLoginPageState createState() => _MemberLoginPageState();
}

class _MemberLoginPageState extends State<MemberLoginPage> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  @override
  void dispose() {
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
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2, -1),
                          color: Colors.grey,
                          blurRadius: 5)
                    ]),
                child: Image.asset(
                  "assets/splash.jpg",
                  height: 200,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Üye Giriş Ekranı",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "E-Posta Adresi",
                  border: OutlineInputBorder(),
                ),
                controller: nameController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Şifre",
                  border: OutlineInputBorder(),
                ),
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
