import 'package:shared_preferences/shared_preferences.dart';

class AppState {
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  final isLoggedInKey = 'isLoggedIn';

  void logIn() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString(isLoggedInKey, 'true');
  }

  void logOut() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString(isLoggedInKey, 'false');
  }

  bool isLoggedIn() {
    _sharedPreferences.then((value) {
      SharedPreferences sharedPreferences = value;
      return parseBool(sharedPreferences.get(isLoggedInKey));
    });
  }

  bool parseBool(String boolInString) {
    return boolInString.toLowerCase() == 'true';
  }
}
