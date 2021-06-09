import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Components/PrimaryButton.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/screens/authorization/name_pass.dart';
import 'package:instagram/size_config.dart';

class VerifyEmail extends StatefulWidget {
  final String? email;
  const VerifyEmail({Key? key, this.email}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  String errorData = " ";
  @override
  Widget build(BuildContext context) {
    String email = widget.email!;
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: 210,
        margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Verify Email Address".toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ktextColor,
                    fontSize: 15)),
            SizedBox(
              height: 10,
            ),
            Text(
                "Open the link we sent you to $email and click the button below.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: ktextColor,
                    fontSize: 15)),
            TextButton(
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;

                if (user != null && !user.emailVerified) {
                  await user.sendEmailVerification();
                }
              },
              child: Text(
                "Resend Code",
                style: TextStyle(
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              style:
                  TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
            ),
            PrimaryButton(
              text: "Next",
              onpressed: () async {
                User? user = FirebaseAuth.instance.currentUser;
                user!.reload().then((value) {
                  print(user.uid);
                  if (user.emailVerified) {
                    user.reload();
                    print("verified");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NamePass(
                        email: widget.email,
                      );
                    }));
                  } else {
                    user.reload();
                    print("Not Verified");
                    setState(() {
                      errorData = "Email not verified! Please try Again";
                    });
                  }
                });
              },
              width: SizeConfig().init(context)[0] - 40,
              height: 45,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              errorData,
              style: TextStyle(fontSize: 15, color: Colors.red),
            )
          ],
        ),
      ),
    ));
  }
}
