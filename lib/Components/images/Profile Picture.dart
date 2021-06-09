import 'package:flutter/material.dart';
import 'package:instagram/constants.dart';

import '../../size_config.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      clipBehavior: Clip.hardEdge,
      width: SizeConfig().init(context)[1] * 0.1,
      height: SizeConfig().init(context)[1] * 0.1,
      decoration: BoxDecoration(
        border: Border.fromBorderSide(BorderSide(color: kinstaOrangeColor)),
        color: Colors.transparent,
        shape: BoxShape.circle,
        image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(
                "https://wallpaperaccess.com/download/cool-profile-pictures-2213424")),
      ),
    );
  }
}
