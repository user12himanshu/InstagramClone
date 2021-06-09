import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Components/images/Profile%20Picture.dart';
import 'package:instagram/Components/profilePage/no_of_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var data;
  int? noofPosts, nooffllowers, noOffollowing;
  List? posts, followers, following;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
          posts = snapshot.data!.get("post");
          followers = snapshot.data!.get("followers");
          following = snapshot.data!.get("following");
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfilePicture(),
                  NoofCard(
                    no: posts!.length.toString(),
                    label: "Posts",
                  ),
                  NoofCard(
                    no: followers!.length.toString(),
                    label: "Followers",
                  ),
                  NoofCard(
                    no: following!.length.toString(),
                    label: "Following",
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("data"), Text("Bio")],
                ),
              )
            ],
          );
        });
  }
}
