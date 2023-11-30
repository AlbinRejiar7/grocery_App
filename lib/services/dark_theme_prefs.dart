import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePrefs {
  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("THEMESTATUS", value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("THEMESTATUS") ?? false;
  }
}
