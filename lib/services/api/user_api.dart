import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kiuqi/constants/links.dart';
import 'package:kiuqi/models/connections_model.dart';
import 'package:kiuqi/models/interactions_model.dart';
import 'package:kiuqi/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<UserModel> getCurrentUserDetails() async {
    String _token = "";
    String _id = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      _token = prefs.getString('token')!;
      _id = prefs.getString('id')!;
    } else {
      throw Exception("Shared Preference not found");
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded',
      'authorization': _token,
    };

    final queryParameters = {'id': _id};

    var uri = Uri.https(APILINK, VERSION + "/cofounder/by-id", queryParameters);
    var response = await http.get(uri, headers: requestHeaders);

    try {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      var body = json.decode(response.body);
      return response.statusCode == 200
          ? UserModel.fromJson(body)
          : throw Exception("User not found");
    } catch (e) {
      throw Exception(
          "Failed to establish connection with API... (Error : $e)");
    }
  }

  static Future<List<ConnectionsModel>> getCurrentUserConnections() async {
    late String _token;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      _token = prefs.getString('token')!;
    } else {
      throw Exception("Shared Preference not found");
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded',
      'authorization': _token,
    };
    Uri uri = Uri.https(APILINK, VERSION + "/cofounder/list-connections");

    var response = await http.get(uri, headers: requestHeaders);

    try {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      return response.statusCode == 200
          ? connectionsModelFromJson(response.body)
          : throw Exception("Status code mismatch...");
    } catch (e) {
      throw Exception(
          "Failed to establish connection with API... (Error : $e)");
    }
  }

  static Future<List<InteractionsModel>> getCurrentUserInteractions(
      {String? interactionType}) async {
    late String _token;
    late Uri uri;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      _token = prefs.getString('token')!;
    } else {
      throw Exception("Shared Preference not found");
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded',
      'authorization': _token,
    };

    if (interactionType == null || interactionType == "") {
      uri = Uri.https(APILINK, VERSION + "/cofounder/list-interactions");
    } else {
      uri = Uri.https(APILINK, VERSION + "/cofounder/list-interactions",
          {'interaction_type': interactionType});
    }

    var response = await http.get(uri, headers: requestHeaders);

    try {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      return response.statusCode == 200
          ? interactionsModelFromJson(response.body)
          : throw Exception("Status code mismatch...");
    } catch (e) {
      throw Exception(
          "Failed to establish connection with API... (Error : $e)");
    }
  }
}
