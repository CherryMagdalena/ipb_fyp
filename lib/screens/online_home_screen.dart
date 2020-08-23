import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ipb_fyp/components/alert_dialog.dart';
import '../components/rounded_clipper.dart';
import '../resources/color.dart';
import 'package:ipb_fyp/components/online_or_offline_text.dart';

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
    connectionListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        ClipPath(
          clipper: RoundedClipper(),
          child: Container(
              height: 300.0,
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.0,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
        ),
        OnlineOrOfflineText(widget.pageController, isOnline: true)
      ],
    );
  }
}