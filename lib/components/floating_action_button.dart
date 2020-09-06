import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipb_fyp/resources/color.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:ipb_fyp/screens/contact_screen.dart';

class CustomFloatingButton extends StatefulWidget {
  @override
  _CustomFloatingButtonState createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      fabColor: kDarkerColor,
      ringColor: Colors.transparent,
      ringDiameter: 250.0,
      ringWidth: 100.0,
      children: [
        FloatingActionButtonMenu(Icons.group_add, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContactScreen();
          }));
        }),
        FloatingActionButtonMenu(Icons.add, () {}),
      ],
    );
//    return FloatingActionButton(
//      backgroundColor: Colors.blue,
//      child: Icon(Icons.menu),
//    );
  }
}

class FloatingActionButtonMenu extends StatelessWidget {
  final IconData iconData;
  final Function function;
  FloatingActionButtonMenu(this.iconData, this.function);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        padding: EdgeInsets.all(20.0),
        shape: CircleBorder(),
        color: kDarkerColor,
        child: Icon(iconData),
        onPressed: function);
  }
}
