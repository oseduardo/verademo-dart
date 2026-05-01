import 'package:shared_preferences/shared_preferences.dart';

class VSharedPrefs {
  late final SharedPreferences prefs;

  static final VSharedPrefs _instance = VSharedPrefs._internal();

  factory VSharedPrefs() => _instance;

  VSharedPrefs._internal();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void clear() {
    prefs.clear();
  }

  void remove(String param) {
    prefs.remove(param);
  }

  String? get username {
    return prefs.getString("username");
  }

  set username(String? value) {
    value != null ? prefs.setString("username", value) : "";
  }

  String? get rememberedUsername {
    return prefs.getString("rememberedUsername");
  }

  set rememberedUsername(String? value) {
    value != null ? prefs.setString("rememberedUsername", value) : "";
  }

  String? get rememberedPassword {
    return prefs.getString("rememberedPassword");
  }

  set rememberedPassword(String? value) {
    value != null ? prefs.setString("rememberedPassword", value) : "";
  }

  String? get token {
    return prefs.getString("token");
  }

  set token(String? value) {
    value != null ? prefs.setString("token", value) : "";
  }

}