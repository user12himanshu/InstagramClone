import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/screens/authorization/firstScreen.dart';
import 'package:instagram/screens/authorization/login.dart';
import 'package:instagram/screens/authorization/name_pass.dart';
import 'package:instagram/screens/authorization/register.dart';
import 'package:instagram/screens/authorization/verifyEmail.dart';
import 'screens/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

enum AuthState { SignedIn, SignedOut }

class _AppState extends State<App> {
  AuthState? state;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        setState(() {
          state = AuthState.SignedOut;
        });
      } else {
        setState(() {
          state = AuthState.SignedIn;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: kprimaryColor,
          primarySwatch: primaryMaterial),
      home: state == AuthState.SignedOut ? FirstScreen() : HomeScreen(),
      routes: {
        "/home": (context) => HomeScreen(),
        "/firstScreen": (context) => FirstScreen(),
        "/register": (context) => Register(),
        "/login": (context) => LogIn(),
        "/verify email": (context) => VerifyEmail(),
        "/name_pass": (context) => NamePass(),
      },
    );
  }
}
