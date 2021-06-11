import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Components/PrimaryButton.dart';
import 'package:instagram/Components/images/Profile%20Picture.dart';
import 'package:instagram/Components/profilePage/no_of_card.dart';

import '../constants.dart';
import '../size_config.dart';
import 'homeScreen.dart';

class OtherUserProfilePage extends StatefulWidget {
  final String? uid;
  final QueryDocumentSnapshot userData;
  const OtherUserProfilePage({Key? key, this.uid, required this.userData})
      : super(key: key);

  @override
  _OtherUserProfilePageState createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  List? posts, followers, following;
  bool? isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.uid!)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              posts = snapshot.data!.get("post");
              followers = snapshot.data!.get("followers");
              following = snapshot.data!.get("following");
              List userFollowing = widget.userData.get("following");
              List userFollowers = widget.userData.get("followers");

              for (String user in userFollowing) {
                if (user == widget.uid) {
                  isFollowing = true;
                }
              }

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
                  isFollowing!
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    isFollowing = false;
                                  });
                                },
                                child: Text(
                                  "Following",
                                  style: TextStyle(
                                      color: ktextColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.5),
                                ),
                                style: OutlinedButton.styleFrom(
                                    fixedSize: Size(
                                        SizeConfig().init(context)[0] / 2 - 40,
                                        20),
                                    splashFactory: NoSplash.splashFactory,
                                    side: BorderSide(color: Colors.grey[400]!)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Text(
                                  "Message",
                                  style: TextStyle(
                                      color: ktextColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.5),
                                ),
                                style: OutlinedButton.styleFrom(
                                    fixedSize: Size(
                                        SizeConfig().init(context)[0] / 2 - 40,
                                        20),
                                    splashFactory: NoSplash.splashFactory,
                                    side: BorderSide(color: Colors.grey[400]!)),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: PrimaryButton(
                            text: "Follow",
                            onpressed: () {
                              followers!.add(widget.userData.id);
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(snapshot.data!.id)
                                  .update({"followers": followers}).then(
                                      (value) {
                                userFollowing.add(snapshot.data!.id);
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(widget.userData.id)
                                    .update({"following": userFollowing}).then(
                                        (value) {
                                  setState(() {
                                    isFollowing = true;
                                  });
                                });
                              });
                            },
                            width: SizeConfig().init(context)[0] - 50,
                            height: 35,
                          )),
                  Container(
                    padding: EdgeInsets.all(3.0),
                    height: SizeConfig().init(context)[1],
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
            }),
      ),
    );
  }
}
