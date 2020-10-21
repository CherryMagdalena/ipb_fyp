import 'package:flutter/material.dart';
import 'package:ipb_fyp/resources/color.dart';
import 'package:ipb_fyp/screens/home_screen.dart';
import 'package:ipb_fyp/screens/log_in_screen.dart';
import 'package:ipb_fyp/screens/settings_screen.dart';

class CustomBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: kPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            PageIcon(
              iconData: Icons.home,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              },
            ),
            Container(
              height: kToolbarHeight,
              width: 200.0,
              child: Center(
                  child: Text(
                'Emergency',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold),
              )),
              decoration: BoxDecoration(color: Colors.red, boxShadow: [
                BoxShadow(
                    color: Colors.black26.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: Offset(0, 5))
              ]),
            ),
            PageIcon(
              iconData: Icons.settings,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return SettingsScreen();
                }));
              },
            )
          ],
        ));
  }
}

class PageIcon extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;
  PageIcon({this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      color: Colors.white,
      onPressed: onPressed,
    );
  }
}
