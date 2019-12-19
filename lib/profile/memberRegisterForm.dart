import 'package:enyenikitap/models/member.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberRegisterForm extends StatefulWidget {
  @override
  _MemberRegisterFormState createState() => _MemberRegisterFormState();
}

class _MemberRegisterFormState extends State<MemberRegisterForm> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController passwordControllerRepeat =
      TextEditingController(text: "");
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    passwordControllerRepeat.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
              "Üye Kayıt Formu",
              textAlign: TextAlign.center,
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
           
            SizedBox(
              height: 50,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "E-Posta",
                border: OutlineInputBorder(),),
              controller: nameController,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Şifre",
                border: OutlineInputBorder(),),
              controller: passwordController,
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Şifre (Tekrar)",
                border: OutlineInputBorder(),
              ),
              controller: passwordControllerRepeat,
              obscureText: true,
            ),
            (Provider.of<MemberRepo>(context).registered == true)
                ? Text("Kayıt Tamamlandı")
                : FlatButton(
                    child: Text("Kayıt"),
                    onPressed: () {
                     // if(passwordController.text==passwordControllerRepeat.text)
                      Provider.of<MemberRepo>(context).register(
                          nameController.text, passwordController.text);
                      /*  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PublisherManagementPage(),
                      ),
                    ); */
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
