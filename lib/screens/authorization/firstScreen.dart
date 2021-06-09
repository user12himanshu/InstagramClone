import 'package:flutter/material.dart';
import 'package:instagram/Components/PrimaryButton.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/size_config.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Center(
          child: Container(
            height: SizeConfig().init(context)[1] * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: SizeConfig().init(context)[1] * 0.3 * 0.25,
                  child: Image.asset("assets/images/logoText.png"),
                ),
                SizedBox(
                  height: 40,
                ),
                PrimaryButton(
                  text: "Create New Account",
                  width: SizeConfig().init(context)[0] - 40,
                  height: 45,
                  onpressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        color: kprimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory),
                )
              ],
            ),
          ),
        ),
        Container()
      ],
    )));
  }
}
