import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Components/images/Profile%20Picture.dart';
import 'package:instagram/screens/other_user_profilePage.dart';
import 'package:instagram/size_config.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

List<Widget> suggestions = [];

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  late QueryDocumentSnapshot userData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List users = [];
          snapshot.data!.docs.forEach((element) {
            users.add(element.get("username"));
          });
          String? userUid = FirebaseAuth.instance.currentUser!.uid;
          snapshot.data!.docs.forEach((element) {
            if (element.id == userUid) {
              userData = element;
            }
          });

          return Column(
            children: [
              Container(
                width: SizeConfig().init(context)[0],
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                    Container(
                        padding: EdgeInsets.all(10),
                        height: 70,
                        width: SizeConfig().init(context)[0] * 0.75,
                        child: TextFormField(
                            controller: controller,
                            onChanged: (value) {
                              int i = -1;
                              List<Widget> temp = [];
                              for (String name in users) {
                                i++;
                                if (value.isEmpty) {
                                  setState(() {
                                    suggestions = [];
                                  });
                                }
                                if (value == name.substring(0, value.length)) {
                                  print(name);
                                  print(snapshot.data!.docs[i].id);
                                  String id = snapshot.data!.docs[i].id;
                                  temp.add(Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return OtherUserProfilePage(
                                              userData: userData,
                                              uid: id,
                                            );
                                          }));
                                        },
                                        leading: ProfilePicture(
                                          url: snapshot.data!.docs[i]
                                              .get("Profilepic"),
                                        ),
                                        title: Text(
                                          snapshot.data!.docs[i]
                                              .get("username"),
                                        ),
                                        subtitle: Text(
                                            snapshot.data!.docs[i].get("Name")),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Colors.grey[300],
                                      )
                                    ],
                                  ));
                                  setState(() {
                                    suggestions = temp;
                                  });
                                }
                              }
                            }))
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
              Container(
                  width: SizeConfig().init(context)[0],
                  height: SizeConfig().init(context)[1] * 0.85 - 70,
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: suggestions,
                  ))
            ],
          );
        });
  }
}
