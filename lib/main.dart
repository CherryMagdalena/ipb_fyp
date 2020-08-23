import 'package:flutter/material.dart';
import 'file:///C:/Users/Cherry/AndroidStudioProjects/ipb_fyp/lib/screens/home_screen.dart';
import 'file:///C:/Users/Cherry/AndroidStudioProjects/ipb_fyp/lib/resources/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
