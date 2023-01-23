import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_request.dart';
import '../model/login_response.dart';

//Store data in local storage
class AppPreference {
  AppPreference._privateConstructor();

  static final AppPreference instance = AppPreference._privateConstructor();

  final String _fcmToken = "fcm-token";
  final String _loginRequest = "login-request";
  final String _loginResponse = "login_response";
  final String accessToken = "access_token";

  Future<void> saveAccessToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(accessToken, token);
    return;
  }

  Future<String> getAccessToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(accessToken) ?? "";
  }

  Future<void> saveFCMToken(token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_fcmToken, token);
    return;
  }

  /// to save any string value with unique key in shared preference
  Future<void> savePrefString(key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
    return;
  }

  /// to get any string value with unique key from shared preference data
  Future<String> getPrefString(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  /// to save any boolean value with unique key in shared preference
  Future<void> savePrefBoolean(key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
    return;
  }

  /// to get any boolean data with unique key from shared preference
  Future<bool> getPrefBoolean(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? false;
  }

  Future<String> getFCMToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_fcmToken) ?? "";
  }

  Future<void> saveLoginResponse(LoginResponse response) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_loginResponse, jsonEncode(response.toJson()));
    return;
  }

  Future<void> saveLoginRequest(LoginRequest request) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_loginRequest, jsonEncode(request.toJson()));
    return;
  }

  Future<Map<String, dynamic>> getLoginRequest() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString(_loginRequest);
    if (session == 'null' || session == null) {
      return {};
    } else if (session.isNotEmpty) {
      return jsonDecode(session);
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> getLoginResponse() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString(_loginResponse);
    if (session == 'null' || session == null) {
      return {};
    } else if (session.isNotEmpty) {
      return jsonDecode(session);
    } else {
      return {};
    }
  }
}
