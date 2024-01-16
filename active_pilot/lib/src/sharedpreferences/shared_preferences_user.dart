
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUser {

  SharedPreferencesUser._internal();

  static final _singleton = SharedPreferencesUser._internal();

  factory SharedPreferencesUser() {
    return _singleton;
  }

  SharedPreferences? prefs;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool get userLogged {
    return prefs?.getBool("user_logged") ?? false;
  }

  set userLogged(bool value) {
    prefs?.setBool("user_logged", value);
  }

  String get jwtToken {
    return prefs?.getString("jwtToken") ?? "";
  }

  set jwtToken(String value) {
    prefs?.setString("jwtToken", value);
  }

  String get refreshToken {
    return prefs?.getString("refreshToken") ?? "";
  }

  set refreshToken(String value) {
    prefs?.setString("refreshToken", value);
  }

  String get userId {
    return prefs?.getString("userId") ?? "";
  }

  set userId(String value) {
    prefs?.setString("userId", value);
  }

  String get role {
    return prefs?.getString("role") ?? "";
  }

  set role(String value) {
    prefs?.setString("role", value);
  }

  bool get isPilot {
    return prefs?.getBool("is_pilot") ?? false;
  }

  set isPilot(bool value) {
    prefs?.setBool("is_pilot", value);
  }

  bool get flyAlone {
    return prefs?.getBool("fly_alone") ?? false;
  }

  set flyAlone(bool value) {
    prefs?.setBool("fly_alone", value);
  }
}