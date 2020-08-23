import 'package:flutter/material.dart';

showNoConnectionDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Connection Lost'),
          content: Text(
              'Please check your internet connection or move to Offline Mode'),
          actions: [
            FlatButton(
              child: Text('Check Connection'),
            ),
            FlatButton(
              child: Text('Move to Offline Mode'),
            )
          ],
        );
      });
}
