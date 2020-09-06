import 'package:flutter/material.dart';
import 'package:ipb_fyp/resources/color.dart';

main() {
  runApp(SignUpScreen());
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: kBackgroundColor,
      home: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('image/logo.png'),
              CustomTextField('Email'),
              SizedBox(height: 20.0),
              CustomTextField('Password')
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hint;
  CustomTextField(this.hint);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: kDarkestColor, borderRadius: BorderRadius.circular(5.0)),
        width: 250.0,
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white)),
        ));
  }
}
