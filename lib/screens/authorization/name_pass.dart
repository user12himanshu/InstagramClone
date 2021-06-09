import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Components/PrimaryButton.dart';
import 'package:instagram/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';
import 'dateOfBirth.dart';

class NamePass extends StatefulWidget {
  final String? email;
  const NamePass({Key? key, this.email}) : super(key: key);

  @override
  _NamePassState createState() => _NamePassState();
}

class _NamePassState extends State<NamePass> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorData = " ";
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Name and password".toUpperCase(),
              style: TextStyle(
                  color: ktextColor, fontWeight: FontWeight.bold, fontSize: 15),
            ),
            TextFormField(
              controller: nameController,
              style: TextStyle(color: ktextColor, fontWeight: FontWeight.w500),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontWeight: FontWeight.normal),
                  filled: true,
                  fillColor: Colors.grey[100],
                  focusColor: Colors.grey[300],
                  hintText: "Full Name",
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 2.0)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 2.0))),
            ),
            TextFormField(
              controller: passwordController,
              style: TextStyle(color: ktextColor, fontWeight: FontWeight.w500),
              keyboardType: TextInputType.name,
              obscureText: hidePass,
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontWeight: FontWeight.normal),
                  filled: true,
                  fillColor: Colors.grey[100],
                  focusColor: Colors.grey[300],
                  hintText: "Password",
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 2.0)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 2.0))),
            ),
            Text(
              errorData,
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
            PrimaryButton(
              text: "Continue",
              onpressed: () async {
                if (passwordController.text.length < 8) {
                  setState(() {
                    errorData = "Your password lenght must be 8 or more.";
                  });
                } else {
                  String email = widget.email!;
                  String password = '@Password';
                  AuthCredential credential = EmailAuthProvider.credential(
                      email: email, password: password);
                  await FirebaseAuth.instance.currentUser!
                      .reauthenticateWithCredential(credential);
                  User? user = FirebaseAuth.instance.currentUser;
                  user!.updatePassword(passwordController.text).then((value) {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(user.uid)
                        .set(
                      {"Name": nameController.text, "Email": widget.email},
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DateofBirth();
                    }));
                  });
                }
              },
              height: 45,
              width: SizeConfig().init(context)[0] - 40,
            )
          ],
        ),
      ),
    ));
  }
}
