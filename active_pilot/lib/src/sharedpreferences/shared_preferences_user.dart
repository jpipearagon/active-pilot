
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUser {

  static final _singleton = SharedPreferencesUser._internal();

  SharedPreferencesUser._internal();

  factory SharedPreferencesUser() {
    return _singleton;
  }


  SharedPreferences prefs;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool get userLogged {
    return prefs.getBool("user_logged") ?? false;
  }

  set userLogged(bool value) {
    prefs.setBool("user_logged", value);
  }

  String get jwtToken {
    return prefs.getString("jwtToken") ?? "";
  }

  set jwtToken(String value) {
    prefs.setString("jwtToken", value);
  }

  String get refreshToken {
    return prefs.getString("refreshToken") ?? "";
  }

  set refreshToken(String value) {
    prefs.setString("refreshToken", value);
  }

  String get userId {
    return prefs.getString("userId") ?? "";
  }

  set userId(String value) {
    prefs.setString("userId", value);
  }
}