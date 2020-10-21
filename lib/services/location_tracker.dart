import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:ipb_fyp/services/firebase.dart';
import 'package:ipb_fyp/services/sms_broadcast.dart';

class LocationTracker {
  StreamSubscription positionStream;
  StreamSubscription onlinePositionStream;
  final FirebaseService firebaseService = FirebaseService();

  Future<Position> getCurrentLocation() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    return position;
  }

  String getLocationString(Position position) {
    String message = 'This is an update of my latest location:';
    DateFormat dateFormat = DateFormat.yMd().add_jm();
    String googleMapsURL = 'https://www.google.com/maps/search/?api=1&query=';
    String time = dateFormat.format(position.timestamp);
    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();
    String mapsQueryURL = '$googleMapsURL$latitude,$longitude';
    String locationString = "$message\n$time\n$mapsQueryURL";
    return locationString;
  }

  //Broadcast location for a duration of time (in minutes) per interval (in minutes)
  void updateLocation({
    @required double intervalInMinute,
    @required int duration,
  }) async {
    Future.delayed(Duration(minutes: duration), () {
      stopLocationUpdate();
    });
    int intervalInMillisecond = (intervalInMinute * 60000).round();
    SMSBroadcast smsBroadcast = SMSBroadcast();
    positionStream = getPositionStream(timeInterval: intervalInMillisecond)
        .listen((Position position) {
      print('Updating position!');
      String location = getLocationString(position);
      smsBroadcast.broadcastSMS(location);
    });
  }

  void updateOnlineLocation() async {
    //Automatically turn off in 2 hours
    Future.delayed(Duration(minutes: 120), () {
      stopOnlineLocationUpdate();
    });
    //Update location every 5 seconds
    onlinePositionStream =
        getPositionStream(timeInterval: 5000).listen((Position position) {
      firebaseService.updateLocation(position);
    });
  }

  void stopLocationUpdate() {
    positionStream?.cancel();
  }

  void stopOnlineLocationUpdate() {
    print('stop online location update');
    onlinePositionStream?.cancel();
    print(onlinePositionStream == null);
  }
}
