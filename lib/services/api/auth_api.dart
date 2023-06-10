import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kiuqi/constants/links.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String? authKey;
String? phoneNumber;

class AuthApi {
  // API call to send OTP
  static Future<bool> sendOtp({ required bool resend, required String phone }) async {
    if (resend == false){
      phoneNumber = phone;
    }
    
    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded'
    };

    var uri = Uri.https(APILINK, VERSION + "/users/send-otp");
    var response = await http.post(
      uri,
      headers: requestHeaders,
      body: {
        "phone": phoneNumber,
      },
    );

    try {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        authKey = body['auth_key'];
        if (kDebugMode) print('auth_key ===== ' + authKey!);

        return true;
      } else {
        var body = json.decode(response.body);
        if (kDebugMode) print(body['message']);
        return false;
      }
    } catch (e) {
      if (kDebugMode) print("login caused due to error: $e");
      return false;
    }
  }

  // API call to verify OTP
  static Future<bool> verifyOtp(String otp) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded'
    };

    SharedPreferences logindata = await SharedPreferences.getInstance();

    var uri = Uri.https(APILINK, VERSION + "/users/verify-otp");
    var response = await http.post(
      uri,
      headers: requestHeaders,
      body: {
        "phone": phoneNumber,
        "otp": otp,
        "auth_key": authKey,
      },
    );

    try {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (kDebugMode) print(body['token']);

        logindata.setBool('status', true);
        logindata.setString('id', body['user']['_id']);
        logindata.setString('token', body['token']);
        if (body['user']['name'] != null) {
          logindata.setString("name", body['user']['name']);
        }
        phoneNumber = null;
        authKey = null;

        return true;
      } else {
        var body = json.decode(response.body);
        if (kDebugMode) print(body['message']);
        logindata.setBool('status', false);
        return false;
      }
    } catch (e) {
      if (kDebugMode) print("login caused due to error: $e");
      return false;
    }
  }
}
