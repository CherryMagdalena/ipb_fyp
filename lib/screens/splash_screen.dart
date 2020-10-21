import 'package:flutter/material.dart';
import 'package:ipb_fyp/resources/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ipb_fyp/screens/home_screen.dart';
import 'package:ipb_fyp/screens/log_in_screen.dart';
import 'package:ipb_fyp/screens/sign_up_screen.dart';
import 'package:ipb_fyp/services/app_state.dart';
import 'package:ipb_fyp/services/firebase.dart';
import 'package:firebase_core/firebase_core.dart';

main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: kBackgroundColor,
        home: Scaffold(
            backgroundColor: kBackgroundColor,
            body: Column(children: [
              Image.asset('image/logo.png'),
              AppState().isLoggedIn() ? HomeScreen : LogInScreen(),
            ])));
  }
}
