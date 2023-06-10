import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kiuqi/constants/links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserDetailsApi {
  static Future<bool> updateUserDetails({
    required String name,
    required String email,
    required String dob,
    required String profilePic,
    required String state,
    required String city,
  }) async {
    String _token = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      _token = prefs.getString('token')!;
    } else {
      return false;
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded',
      'authorization': _token,
    };

    var uri = Uri.https(APILINK, VERSION + "/users/update-details/user");

    var response = await http.post(
      uri,
      headers: requestHeaders,
      body: {
        "name": name,
        "email": email,
        "dob": dob,
        "profile_pic": profilePic,
        "state": state,
        "city": city,
      },
    );

    try {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        return true;
      } else {
        var body = json.decode(response.body);
        if (kDebugMode) print(body['message']);
        return false;
      }
    } catch (e) {
      if (kDebugMode) print("failed to update data due to error: $e");
      return false;
    }
  }

  static Future<bool> updateStartupDetails({
    required String name,
    required String legalName,
    required String tagline,
    required String industry,
    required String dateFounded,
    required String kvIncubationId,
  }) async {
    String _token = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      _token = prefs.getString('token')!;
    } else {
      return false;
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded',
      'authorization': _token,
    };

    var uri = Uri.https(APILINK, VERSION + "/users/update-details/startup");

    var response = await http.post(
      uri,
      headers: requestHeaders,
      body: {
        "name": name,
        "legal_name": legalName,
        "tagline": tagline,
        "industry": industry,
        "date_founded": dateFounded,
        "kv_incubation_id": kvIncubationId,
      },
    );

    try {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        return true;
      } else {
        var body = json.decode(response.body);
        if (kDebugMode) print(body['message']);
        return false;
      }
    } catch (e) {
      if (kDebugMode) print("failed to update data due to error: $e");
      return false;
    }
  }

  static Future<bool> updateResumeDetails({
    required String bio,
    required String category,
    required String expertise,
    required String startupCount,
    required String skills,
    required String hasStartup,
  }) async {
    String _token = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      _token = prefs.getString('token')!;
    } else {
      return false;
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded',
      'authorization': _token,
    };

    var uri = Uri.https(APILINK, VERSION + "/users/update-details/resume");

    var response = await http.post(
      uri,
      headers: requestHeaders,
      body: {
        "bio": bio,
        "category": category,
        "expertise": expertise,
        "startup_count": startupCount,
        "skills": skills,
        "has_startup": hasStartup,
      },
    );

    try {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        return true;
      } else {
        var body = json.decode(response.body);
        if (kDebugMode) print(body['message']);
        return false;
      }
    } catch (e) {
      if (kDebugMode) print("failed to update data due to error: $e");
      return false;
    }
  }
}
