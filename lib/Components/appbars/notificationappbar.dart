import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import '../../size_config.dart';

PreferredSizeWidget notificationappBar(BuildContext context) {
  PreferredSizeWidget notificationappbar = AppBar(
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
  );
  return notificationappbar;
}
