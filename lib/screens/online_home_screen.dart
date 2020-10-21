import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ipb_fyp/components/alert_dialog.dart';
import 'package:ipb_fyp/services/firebase.dart';
import 'package:ipb_fyp/services/location_tracker.dart';
import 'package:ipb_fyp/services/sms_broadcast.dart';
import '../components/rounded_clipper.dart';
import '../resources/color.dart';
import 'package:ipb_fyp/components/online_or_offline_text.dart';
import 'package:ipb_fyp/resources/text_style.dart';
import 'package:ipb_fyp/components/menu_button.dart';
import 'package:firebase_core/firebase_core.dart';

bool isTrackingOnline;

class OnlineHomeScreen extends StatefulWidget {
  final PageController pageController;
  OnlineHomeScreen(this.pageController);

  @override
  _OnlineHomeScreenState createState() => _OnlineHomeScreenState();
}

class _OnlineHomeScreenState extends State<OnlineHomeScreen> {
  final snackBar = SnackBar(content: Text('Not connected to the internet'));
  var connectionListener;

  @override
  void initState() {
    print('init online home screen');
    isTrackingOnline ??= false;
    //Check if device is connected to the internet, if not then cannot open this screen
    DataConnectionChecker().hasConnection.then((isOnline) {
      connectionListener =
          DataConnectionChecker().onStatusChange.listen((status) {
        switch (status) {
          case DataConnectionStatus.connected:
            break;
          case DataConnectionStatus.disconnected:
            showNoConnectionDialog(context);
            widget.pageController.animateToPage(1,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
            break;
        }
      });
      if (!isOnline) {
        widget.pageController.animateToPage(1,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
        Scaffold.of(context).showSnackBar(snackBar);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    connectionListener ?? connectionListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build method of future builder');
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          showNoConnectionDialog(context);
          widget.pageController.animateToPage(1,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          LocationTracker _locationTracker = LocationTracker();
          if (!FirebaseService().isLoggedIn()) {
            widget.pageController.animateToPage(1,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
//            showNotLoggedInDialog(context);
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipPath(
                  clipper: RoundedClipper(),
                  child: Container(
                      height: 270.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [kPrimaryColor, kDarkestColor])),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Image.asset(
                                      'image/cropped_location.png',
                                      width: 175,
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  Positioned(
                                    top: 75,
                                    left: 220,
                                    child: Text(
                                      'Online',
                                      style: kHomeScreenTitle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                ),
                OnlineOrOfflineText(widget.pageController, isOnline: true),
                InactiveMenuButton(
                    text: 'Online Chat', iconData: Icons.chat_bubble),
                Container(
                  child: isTrackingOnline
                      ? ActiveMenuButton(
                          text: 'Live Location',
                          iconData: Icons.location_searching,
                          onPressed: () {
                            _locationTracker.stopOnlineLocationUpdate();
                            setState(() {
                              isTrackingOnline = false;
                            });
                          },
                        )
                      : InactiveMenuButton(
                          text: 'Live Location',
                          iconData: Icons.location_searching,
                          onPressed: () async {
                            setState(() {
                              isTrackingOnline = true;
                              _sendLinkSMS();
                            });
                            Future.delayed(Duration(minutes: 120), () {
                              isTrackingOnline = false;
                              if (this.mounted) {
                                setState(() {});
                              }
                            });
                            _locationTracker.updateOnlineLocation();
                          },
                        ),
                )
              ],
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }

  void _sendLinkSMS() async {
    SMSBroadcast().broadcastLinkSMS(await FirebaseService().getDocumentId());
  }
}
