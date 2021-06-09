import 'package:flutter/material.dart';
import 'package:instagram/Components/images/Profile%20Picture.dart';
import '../size_config.dart';

class HomePageElement extends StatefulWidget {
  const HomePageElement({Key? key}) : super(key: key);

  @override
  _HomePageElementState createState() => _HomePageElementState();
}

class _HomePageElementState extends State<HomePageElement> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Container(
          height: SizeConfig().init(context)[1] * 0.13,
          child: ListView(
            children: [ProfilePicture()],
          ),
        )
      ],
    );
  }
}
