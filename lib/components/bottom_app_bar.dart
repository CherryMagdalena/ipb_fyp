import 'package:flutter/material.dart';
import 'file:///C:/Users/Cherry/AndroidStudioProjects/ipb_fyp/lib/resources/color.dart';

class CustomBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: kDarkerColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            PageIcon(
              iconData: Icons.home,
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
      color: kBackgroundColor,
      onPressed: onPressed,
    );
  }
}
