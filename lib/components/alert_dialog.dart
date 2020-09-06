import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';

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
              child: Text('Open Settings'),
              onPressed: () {
                AppSettings.openWIFISettings();
              },
            ),
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}
