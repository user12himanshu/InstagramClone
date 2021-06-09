import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/Components/appbars/homebar.dart';
import 'package:instagram/Components/appbars/notificationappbar.dart';
import 'package:instagram/Components/appbars/profile_appbar.dart';
import 'package:instagram/Components/appbars/reelsbar.dart';
import 'package:instagram/Components/appbars/searchappbar.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/screens/authorization/reelsPage.dart';
import 'package:instagram/screens/homescreen_element.dart';
import 'package:instagram/screens/notificationPage.dart';
import 'package:instagram/screens/profilePage.dart';
import 'package:instagram/screens/searchPage.dart';
import 'package:instagram/services/userProfile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List screens = [
    HomePageElement(),
    SearchPage(),
    ReelsPage(),
    NotificationPage(),
    ProfilePage()
  ];
  IconData homeicon = Icons.home_filled;
  IconData searchicon = Icons.search_outlined;
  IconData notificationicon = FontAwesomeIcons.heart;
  IconData profileicon = Icons.person_outline;
  String? username;
  int index = 0;
  var data;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              username = snapshot.data!.get("username");
              List appbars = [
                homeappBar(context),
                searchappBar(context),
                reelsappBar(context),
                notificationappBar(context),
                profileappBar(context, username),
              ];

              return Scaffold(
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: index,
                    onTap: (int page) {
                      setState(() {
                        index = page;
                        if (page == 0) {
                          homeicon = Icons.home_filled;
                          searchicon = Icons.search_outlined;
                          notificationicon = FontAwesomeIcons.heart;
                          profileicon = Icons.person_outline;
                        } else if (page == 1) {
                          searchicon = FontAwesomeIcons.search;
                          homeicon = Icons.home_outlined;
                          notificationicon = FontAwesomeIcons.heart;
                          profileicon = Icons.person_outline;
                        } else if (page == 2) {
                          homeicon = Icons.home_outlined;
                          searchicon = Icons.search_outlined;
                          notificationicon = FontAwesomeIcons.heart;
                          profileicon = Icons.person_outline;
                        } else if (page == 3) {
                          homeicon = Icons.home_outlined;
                          searchicon = Icons.search_outlined;
                          notificationicon = FontAwesomeIcons.heart;
                          profileicon = Icons.person_outline;
                        } else if (page == 4) {
                          searchicon = Icons.search_outlined;
                          homeicon = Icons.home_outlined;
                          notificationicon = FontAwesomeIcons.heart;
                          profileicon = Icons.person;
                        }
                      });
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(homeicon, color: ktextColor),
                        label: " ",
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(
                            searchicon,
                            color: ktextColor,
                          ),
                          label: " "),
                      BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.video, color: ktextColor),
                        label: " ",
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(notificationicon, color: ktextColor),
                          label: " "),
                      BottomNavigationBarItem(
                          icon: Icon(profileicon, color: ktextColor),
                          label: " "),
                    ],
                  ),
                  appBar: appbars[index],
                  body: screens[index]);
            }));
  }
}
