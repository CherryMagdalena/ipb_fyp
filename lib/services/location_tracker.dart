import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class LocationTracker {
  Future<Position> getCurrentLocation() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<String> getLocationString() async {
    String message = 'This is an update of my latest location:';
    DateFormat dateFormat = DateFormat.yMd().add_jm();
    String googleMapsURL = 'https://www.google.com/maps/search/?api=1&query=';
    Position position = await getCurrentLocation();
    String time = dateFormat.format(position.timestamp);
    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();
    String mapsQueryURL = '$googleMapsURL$latitude,$longitude';
    String locationString = "$message\n$time\n$mapsQueryURL";
    return locationString;
  }
}
