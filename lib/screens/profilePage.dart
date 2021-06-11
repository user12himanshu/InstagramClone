import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Components/images/Profile%20Picture.dart';
import 'package:instagram/Components/profilePage/no_of_card.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/size_config.dart';

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
                  ProfilePicture(
                    url: snapshot.data!.get("Profilepic"),
                  ),
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
                width: SizeConfig().init(context)[0] * 0.1,
                padding: EdgeInsets.fromLTRB(
                    20, 20, SizeConfig().init(context)[0] * 0.18, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data!.get("Name"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: ktextColor)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      snapshot.data!.get("Bio"),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: ktextColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: ktextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.5),
                  ),
                  style: OutlinedButton.styleFrom(
                      fixedSize: Size(SizeConfig().init(context)[0], 20),
                      splashFactory: NoSplash.splashFactory,
                      side: BorderSide(color: Colors.grey[400]!)),
                ),
              ),
              Container(
                padding: EdgeInsets.all(3.0),
                height: SizeConfig().init(context)[1],
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: posts!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: GridTile(
                        child: Image.network(
                          snapshot.data!.get("post")[index],
                          scale: 1.5,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        });
  }
}
