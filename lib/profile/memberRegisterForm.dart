import 'package:enyenikitap/models/member.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberRegisterForm extends StatefulWidget {
  @override
  _MemberRegisterFormState createState() => _MemberRegisterFormState();
}

class _MemberRegisterFormState extends State<MemberRegisterForm> {
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
        children: <Widget>[
            Text(
              "Kayıt Ekranı",
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
            (Provider.of<MemberRepo>(context).registered == true)
                ? Text("Kayıt Tamamlandı")
                : FlatButton(
                    child: Text("Kayıt"),
                    onPressed: () {
                      Provider.of<MemberRepo>(context)
                          .register(nameController.text, passwordController.text);
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
