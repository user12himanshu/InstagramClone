import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Components/PrimaryButton.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/screens/authorization/username.dart';
import 'package:instagram/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DateofBirth extends StatefulWidget {
  const DateofBirth({Key? key}) : super(key: key);

  @override
  _DateofBirthState createState() => _DateofBirthState();
}

class _DateofBirthState extends State<DateofBirth> {
  String? date;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cake_outlined,
            size: 80,
          ),
          Text(
            "Add your date of birth",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: ktextColor),
          ),
          Text(
            "This won't be part of your public profile.",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700]),
          ),
          Container(
              padding: EdgeInsets.all(20),
              height: 200,
              child: InputDatePickerFormField(
                initialDate: DateTime(2006),
                lastDate: DateTime(2006),
                firstDate: DateTime(1945),
                onDateSubmitted: (value) {
                  date = value.toString();
                },
                onDateSaved: (value) {
                  date = value.toString();
                },
              )),
          PrimaryButton(
            onpressed: () {
              User? user = FirebaseAuth.instance.currentUser;
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(user!.uid)
                  .update({"DOB": date, "username": ""}).then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UsernamePage();
                }));
              });
            },
            text: "Next",
            height: 45,
            width: SizeConfig().init(context)[0] - 40,
          )
        ],
      ),
    ));
  }
}
