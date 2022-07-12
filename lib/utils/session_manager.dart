import 'package:corporatetransportapp/utils/encryptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const userProfile = "userProfile";
  static const tokenKey = "token";
  static const userRole = "role";

  static saveUser(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userProfile, Encryptor.encrypt(value));
  }

  static Future<bool> hasUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(userProfile);
  }

  static Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return Encryptor.decrypt(prefs.getString(userProfile) ?? "{}");
  }

  static removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userProfile);
  }

  static saveRole(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userRole, Encryptor.encrypt(value));
  }

  static Future<String> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return Encryptor.decrypt(prefs.getString(userRole) ?? "");
  }

  static removeRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userRole);
  }

  static saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(tokenKey, Encryptor.encrypt(token));
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Encryptor.decrypt(prefs.getString(tokenKey) ?? '');
  }

  Future<bool> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userProfile);
    prefs.remove(userRole);
    prefs.remove(tokenKey);

    return prefs.containsKey(userProfile) && prefs.containsKey(userRole);
  }
}
