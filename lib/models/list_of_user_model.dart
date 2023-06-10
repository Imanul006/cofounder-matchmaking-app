// To parse this JSON data, do
//
//     final listOfUserModel = listOfUserModelFromJson(jsonString);

import 'dart:convert';

import 'package:kiuqi/models/user_model.dart';

List<UserModel> listOfUserModelFromJson(String str) => json.decode(str) == null ? [] : List<UserModel>.from(json.decode(str)!.map((x) => UserModel.fromJson(x)));

String listOfUserModelToJson(List<UserModel?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

