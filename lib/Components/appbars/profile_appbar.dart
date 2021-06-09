import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/services/userProfile.dart';

import '../../constants.dart';
import '../../size_config.dart';

PreferredSizeWidget profileappBar(BuildContext context, String? username) {
  PreferredSizeWidget profileappbar = AppBar(
    actions: [
      IconButton(
          onPressed: () {},
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
