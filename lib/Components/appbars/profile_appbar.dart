import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';

PreferredSizeWidget profileappBar(BuildContext context, String? username) {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user!.uid;
  File? image;
  PreferredSizeWidget profileappbar = AppBar(
    actions: [
      IconButton(
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: new Icon(
                          Icons.grid_on,
                          color: ktextColor,
                        ),
                        title: new Text('Feed Post'),
                        onTap: () {
                          List? posts;
                          String imageUrl;
                          ImagePicker.platform
                              .pickImage(source: ImageSource.gallery)
                              .then((value) {
                            image = File(value!.path);
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(uid)
                                .get()
                                .then((value) {
                              posts = value["post"];
                              int imageNumber = posts!.length + 1;
                              FirebaseStorage.instance
                                  .ref("users/$uid/post/image$imageNumber")
                                  .putFile(image!)
                                  .then((value) {
                                FirebaseStorage.instance
                                    .ref("users/$uid/post/image$imageNumber")
                                    .getDownloadURL()
                                    .then((value) {
                                  imageUrl = value;
                                  posts!.add(imageUrl);
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(uid)
                                      .update({"post": posts});
                                });
                              });
                            });
                          });
                        },
                      ),
                      ListTile(
                        leading: new Icon(
                          Icons.circle_outlined,
                          color: ktextColor,
                        ),
                        title: new Text('Story'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: new Icon(
                          Icons.videocam,
                          color: ktextColor,
                        ),
                        title: new Text('IGTV Video'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                });
          },
          icon: Icon(
            Icons.add_box_outlined,
            color: ktextColor,
            size: 30,
          )),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: ktextColor,
            size: 30,
          )),
    ],
    leadingWidth: 0,
    elevation: 0,
    backgroundColor: Colors.white,
    title: Text(
      username!,
      style: TextStyle(
          color: ktextColor, fontWeight: FontWeight.bold, fontSize: 23),
    ),
  );
  return profileappbar;
}
