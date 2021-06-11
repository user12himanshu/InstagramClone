import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Components/images/Profile%20Picture.dart';
import '../size_config.dart';

class HomePageElement extends StatefulWidget {
  const HomePageElement({Key? key}) : super(key: key);

  @override
  _HomePageElementState createState() => _HomePageElementState();
}

class _HomePageElementState extends State<HomePageElement> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                height: SizeConfig().init(context)[1] * 0.13,
                child: ListView(
                  children: [
                    ProfilePicture(
                      url: snapshot.data!.get("Profilepic"),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }
}
