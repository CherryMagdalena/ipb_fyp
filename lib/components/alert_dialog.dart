import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:ipb_fyp/screens/log_in_screen.dart';

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

showSkipRegistrationDialog(BuildContext context, Function onSkip) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Skip Registration?'),
          content: Text(
              'Are you sure you want to skip registration? Skipping registration will prevent you from using the online features'),
          actions: [
            FlatButton(
              child: Text('Open Settings'),
              onPressed: onSkip,
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

showNotLoggedInDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not Logged In'),
          content: Text('You are not logged in yet'),
          actions: [
            FlatButton(
                child: Text('Log In'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogInScreen()));
                }),
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
