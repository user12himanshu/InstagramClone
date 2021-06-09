import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Components/PrimaryButton.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/screens/authorization/phoneauth/phn_namepass.dart';
import 'package:instagram/screens/authorization/verifyEmail.dart';
import 'package:instagram/screens/homeScreen.dart';
import 'package:instagram/size_config.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical:
                        ((SizeConfig().init(context)[1] * 0.23) + 150) / 2.55),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: SizeConfig().init(context)[0] * 0.4,
                        height: SizeConfig().init(context)[1] * 0.23,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1)),
                        child: Image.asset("assets/images/userIcon.png")),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        width: SizeConfig().init(context)[0],
                        child: TabBar(
                          labelStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          indicatorColor: ktextColor,
                          labelColor: ktextColor,
                          tabs: [
                            Tab(
                              text: "PHONE NUMBER",
                            ),
                            Tab(
                              text: "EMAIL ADDRESS",
                            ),
                          ],
                        )),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 200,
                      child: TabBarView(
                        children: [PhnRegister(), EmailRegister()],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Divider(
                    thickness: 1.5,
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an Account?"),
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class PhnRegister extends StatefulWidget {
  const PhnRegister({Key? key}) : super(key: key);

  @override
  _PhnRegisterState createState() => _PhnRegisterState();
}

class _PhnRegisterState extends State<PhnRegister> {
  bool codeSentbool = false;
  String? otp;
  TextEditingController phnController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          controller: phnController,
          style: TextStyle(color: ktextColor, fontWeight: FontWeight.w500),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              hintStyle: TextStyle(fontWeight: FontWeight.normal),
              filled: true,
              fillColor: Colors.grey[100],
              prefixText: "IN  +91   ",
              prefixStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 16),
              focusColor: Colors.grey[300],
              hintText: "Phone Number",
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 2.0)),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey[300]!, width: 2.0))),
        ),
        Text(
          "You may recieve SMS updates from Instagram and can opt out at any time.",
          style:
              TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        PrimaryButton(
          text: "Next",
          onpressed: () {
            print("+91" + phnController.text);
            phoneregister(phnController.text);
          },
          height: 45,
          width: SizeConfig().init(context)[0] - 40,
        )
      ],
    );
  }

  Future<void> phoneregister(String phoneNo) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential).then(
            (value) =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                })));
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Enter OTP for verification"),
                content: Column(
                  children: [
                    TextFormField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: InputDecoration(
                        hintText: "Enter OTP here",
                      ),
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () async {
                        final code = otpController.text.trim();
                        PhoneAuthCredential credential =
                            await PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);
                        UserCredential result = await FirebaseAuth.instance
                            .signInWithCredential(credential);

                        User? user = result.user;

                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhnNamePass(
                                        phn: phnController.text.trim(),
                                      )));
                        } else {
                          print("Error");
                        }
                      },
                      child: Text("Submit")),
                  TextButton(onPressed: () {}, child: Text("Cancel")),
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }
}

class EmailRegister extends StatefulWidget {
  const EmailRegister({Key? key}) : super(key: key);

  @override
  _EmailRegisterState createState() => _EmailRegisterState();
}

class _EmailRegisterState extends State<EmailRegister> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextFormField(
          controller: controller,
          style: TextStyle(color: ktextColor, fontWeight: FontWeight.w500),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintStyle: TextStyle(fontWeight: FontWeight.normal),
              filled: true,
              fillColor: Colors.grey[100],
              focusColor: Colors.grey[300],
              hintText: "Email address",
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 2.0)),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey[300]!, width: 2.0))),
        ),
        PrimaryButton(
          text: "Next",
          onpressed: () async {
            try {
              UserCredential userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: controller.text, password: "@Password");
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }

            User? user = FirebaseAuth.instance.currentUser;

            if (user != null && !user.emailVerified) {
              await user.sendEmailVerification();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return VerifyEmail(
                  email: controller.text,
                );
              }));
            }
          },
          height: 45,
          width: SizeConfig().init(context)[0] - 40,
        )
      ],
    );
  }
}
