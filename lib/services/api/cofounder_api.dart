import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kiuqi/constants/links.dart';
import 'package:kiuqi/models/cofounder_list_model.dart';
import 'package:kiuqi/models/list_of_user_model.dart';
import 'package:kiuqi/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CofounderApi {
  static Future<CofounderListModel> fetchUsersByPagination(
      {required int page}) async {
    String _token = await _getToken();
    final int _limit = API_FETCH_LIMIT;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded',
      'authorization': _token,
    };

    final queryParameters = {
      'limit': _limit.toString(),
      'page': page.toString(),
    };

    var uri = Uri.https(APILINK, VERSION + "/cofounder/all", queryParameters);
    var response = await http.get(uri, headers: requestHeaders);

    try {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      var body = json.decode(response.body);
      CofounderListModel _result = CofounderListModel.fromJson(body);
      _result.results!.removeWhere((element) => !checkItemHasDetails(element));

      return response.statusCode == 200
          ? (_result.totalPages! >= page
              ? _result
              : throw Exception("No data available..."))
          : throw Exception("Wrong input data...");
    } catch (e) {
      throw Exception(
          "Failed to establish connection with API... (Error : $e)");
    }
  }

  static Future<bool> sendRequest(String id) async {
    Uri uri = Uri.https(APILINK, VERSION + "/cofounder/send-request");
    return await _sendAction(id, uri);
  }

  static Future<bool> unsendRequest(String id) async {
    Uri uri = Uri.https(APILINK, VERSION + "/cofounder/unsend-request");
    return await _sendAction(id, uri);
  }

  static Future<bool> acceptRequest(String id) async {
    Uri uri = Uri.https(APILINK, VERSION + "/cofounder/accept-request");
    return await _sendAction(id, uri);
  }

  static Future<bool> deleteRequest(String id) async {
    Uri uri = Uri.https(APILINK, VERSION + "/cofounder/reject-request");
    return await _sendAction(id, uri);
  }

  static Future<bool> removeConnection(String id) async {
    Uri uri = Uri.https(APILINK, VERSION + "/cofounder/remove-connection");
    return await _sendAction(id, uri);
  }

  static Future<bool> like(String id) async {
    Uri uri = Uri.https(APILINK, VERSION + "/cofounder/like");
    return await _sendAction(id, uri);
  }

  static Future<bool> reject(String id) async {
    Uri uri = Uri.https(APILINK, VERSION + "/cofounder/reject");
    return await _sendAction(id, uri);
  }

  static Future<bool> _sendAction(String id, Uri uri) async {
    String _token = await _getToken();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded',
      'authorization': _token,
    };

    var response =
        await http.post(uri, headers: requestHeaders, body: {"id": id});

    try {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      return response.statusCode == 200 ? true : false;
    } catch (e) {
      return false;
    }
  }

  static Future<List<UserModel>> fetchUsersByInteractionType(
      {required String interactionType}) async {
    String _token = await _getToken();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded',
      'authorization': _token,
    };

    final queryParameters = {
      'interaction_type': interactionType,
    };

    var uri = Uri.https(
        APILINK, VERSION + "/cofounder/list-interacted-users", queryParameters);
    var response = await http.get(uri, headers: requestHeaders);

    try {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      List<UserModel> _result =listOfUserModelFromJson(response.body);
      print("Resultttttt2 :::::::::::::: " + _result.toString());

      return response.statusCode == 200
          ? _result
          : throw Exception("Wrong input data...");
    } catch (e) {
      throw Exception(
          "Failed to establish connection with API... (Error : $e)");
    }
  }

  static Future<String> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      return (prefs.getString('token')!);
    } else {
      throw Exception("Shared Preference not found");
    }
  }
}

bool checkItemHasDetails(UserModel user) {
  if (user.name == null ||
      user.name == "" ||
      user.resume == null ||
      user.resume!.category == null ||
      user.resume!.category! == "") {
    return false;
  } else {
    return true;
  }
}
