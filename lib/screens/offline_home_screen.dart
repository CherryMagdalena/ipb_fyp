import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:ipb_fyp/components/online_or_offline_text.dart';
import '../components/rounded_clipper.dart';
import '../resources/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OfflineHomeScreen extends StatefulWidget {
  final PageController pageController;
  OfflineHomeScreen(this.pageController);

  @override
  _OfflineHomeScreenState createState() => _OfflineHomeScreenState();
}

class _OfflineHomeScreenState extends State<OfflineHomeScreen> {
  var connectionListener;

  @override
  void initState() {
    connectionListener =
        DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          final snackBar = SnackBar(content: Text('Connected to internet!'));
          Scaffold.of(context).showSnackBar(snackBar);
          break;
        case DataConnectionStatus.disconnected:
          break;
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
                      colors: [kSecondaryColor, Colors.black12])),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 190.0, bottom: 20.0),
                            child: SvgPicture.asset(
                              'image/void.svg',
                              width: 220,
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          Positioned(
                            top: 85,
                            left: 45,
                            child: Text(
                              'Offline',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.0,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Positioned(
                              top: 55.0,
                              left: 300.0,
                              child: SizedBox(
                                width: 60.0,
                                child: Image.asset(
                                  'image/no_wifi.png',
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ])),
        ),
        OnlineOrOfflineText(widget.pageController, isOnline: false)
      ],
    );
  }
}
