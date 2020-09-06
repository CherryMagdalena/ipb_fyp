import 'package:flutter/material.dart';
import 'package:ipb_fyp/resources/color.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function onPressed;
  MenuButton({this.text, this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: GestureDetector(
        child: Container(
          width: 320.0,
          height: 100.0,
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: kDarkestColor.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
              Icon(
                iconData,
                color: Colors.white,
                size: 50.0,
              )
            ],
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
