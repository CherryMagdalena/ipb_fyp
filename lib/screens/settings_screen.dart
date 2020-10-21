import 'package:flutter/material.dart';
import 'package:ipb_fyp/components/alert_dialog.dart';
import 'package:ipb_fyp/components/bottom_app_bar.dart';
import 'package:ipb_fyp/components/menu_button.dart';
import 'package:ipb_fyp/resources/color.dart';
import 'package:ipb_fyp/screens/log_in_screen.dart';
import 'package:ipb_fyp/services/app_state.dart';
import 'package:ipb_fyp/services/firebase.dart';
import 'package:firebase_core/firebase_core.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          bottomNavigationBar: CustomBottomAppBar(),
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text('Settings'),
          ),
          body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FirebaseService().isLoggedIn()
                      ? Container()
                      : InactiveMenuButton(
                          iconData: Icons.login,
                          text: 'Log In',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInScreen()));
                          },
                        ),
                  InactiveMenuButton(
                    iconData: Icons.logout,
                    text: 'Log Out',
                    onPressed: () async {
                      if (Firebase.app() != null) {
                        if (FirebaseService().isLoggedIn()) {
                          FirebaseService().logOut();
                          AppState().logOut();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LogInScreen();
                          }));
                        } else {
                          showNotLoggedInDialog(context);
                        }
                      } else {
                        await Firebase.initializeApp();
                      }
                    },
                  ),
                ]),
          )),
    );
  }
}
