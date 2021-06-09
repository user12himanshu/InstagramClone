import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Components/PrimaryButton.dart';
import 'package:instagram/screens/homeScreen.dart';
import 'package:instagram/size_config.dart';
import '../../constants.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({Key? key}) : super(key: key);

  @override
  _UsernamePageState createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  TextEditingController controller = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference collection =
      FirebaseFirestore.instance.collection("users");
  String errorData = " ";
  bool usernameAvailable = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Set Username",
              style: TextStyle(
                  color: ktextColor, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Choose a username for your account. You can always change it later.",
              style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                collection.get().then((QuerySnapshot querySnapshot) {
                  querySnapshot.docs.forEach((doc) {
                    if (doc["username"] == controller.text) {
                      setState(() {
                        usernameAvailable = false;
                        errorData = "Username Not Available";
                      });
                    } else {
                      setState(() {
                        usernameAvailable = true;
                        errorData = " ";
                      });
                    }
                  });
                });
              },
              controller: controller,
              style: TextStyle(color: ktextColor, fontWeight: FontWeight.w500),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  suffix: usernameAvailable
                      ? Icon(
                          Icons.done,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                  hintStyle: TextStyle(fontWeight: FontWeight.normal),
                  filled: true,
                  fillColor: Colors.grey[100],
                  focusColor: Colors.grey[300],
                  hintText: "Username",
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 2.0)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 2.0))),
            ),
            Text(
              errorData,
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.w400),
            ),
            PrimaryButton(
              text: "Next",
              onpressed: () {
                if (usernameAvailable) {
                  collection
                      .doc(user!.uid)
                      .update({"username": controller.text});
                  collection.doc(user!.uid).update({
                    "post": [],
                    "followers": [],
                    "following": [],
                    "Bio": "",
                    "Profilepic": ""
                  });
                  print("Done");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                }
              },
              width: SizeConfig().init(context)[0] - 40,
              height: 45,
            )
          ],
        ),
      ),
    ));
  }
}
