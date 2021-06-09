import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/Components/images/Profile%20Picture.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (int page) {
              setState(() {
                index = page;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit),
                label: "Test",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Test"),
              BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Test"),
            ],
          ),
          appBar: AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.paperPlane,
                      color: ktextColor,
                    )),
              )
            ],
            leadingWidth: 0,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Image.asset(
              "assets/images/logoText.png",
              width: SizeConfig().init(context)[0] * 0.35,
              height: SizeConfig().init(context)[0] * 0.35,
            ),
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                height: SizeConfig().init(context)[1] * 0.13,
                child: ListView(
                  children: [ProfilePicture()],
                ),
              )
            ],
          )),
    );
  }
}
