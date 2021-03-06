import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:ipb_fyp/components/menu_button.dart';
import 'package:ipb_fyp/components/online_or_offline_text.dart';
import 'package:ipb_fyp/resources/text_style.dart';
import 'package:ipb_fyp/services/location_tracker.dart';
import 'package:ipb_fyp/services/sms_broadcast.dart';
import '../components/rounded_clipper.dart';
import '../resources/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

bool isTracking;

class OfflineHomeScreen extends StatefulWidget {
  final PageController pageController;
  OfflineHomeScreen(this.pageController);

  @override
  _OfflineHomeScreenState createState() => _OfflineHomeScreenState();
}

class _OfflineHomeScreenState extends State<OfflineHomeScreen> {
  var connectionListener;
  LocationTracker _locationTracker = LocationTracker();

  @override
  void initState() {
    isTracking ??= false;
    connectionListener =
        DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          final snackBar = SnackBar(
              backgroundColor: Colors.green,
              content: Text('Connected to internet!'));
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
    connectionListener ?? connectionListener.cancel();
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
              height: 270.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [kDarkerColor, Colors.black45])),
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
                              style: kHomeScreenTitle,
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
        OnlineOrOfflineText(widget.pageController, isOnline: false),
        InactiveMenuButton(
          text: 'SMS Broadcast',
          iconData: Icons.email,
          onPressed: () {
            SMSBroadcast().openSMSRoom();
          },
        ),
        Container(
          child: isTracking
              ? ActiveMenuButton(
                  text: 'Track Location',
                  iconData: Icons.location_searching,
                  onPressed: () {
                    _locationTracker.stopLocationUpdate();
                    setState(() {
                      isTracking = false;
                    });
                  },
                )
              : InactiveMenuButton(
                  text: 'Track Location',
                  iconData: Icons.location_searching,
                  onPressed: () async {
                    setState(() {
                      isTracking = true;
                    });
                    int duration = 1;
                    Future.delayed(Duration(minutes: duration), () {
                      isTracking = false;
                      if (this.mounted) {
                        setState(() {});
                      }
                    });
                    _locationTracker.updateLocation(
                        duration: duration, intervalInMinute: 0.5);
                  },
                ),
        )
      ],
    );
  }
}
