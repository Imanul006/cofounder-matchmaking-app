// To parse this JSON data, do
//
//     final connectionsModel = connectionsModelFromJson(jsonString);

import 'dart:convert';

List<ConnectionsModel> connectionsModelFromJson(String str) => List<ConnectionsModel>.from(json.decode(str).map((x) => ConnectionsModel.fromJson(x)));

String connectionsModelToJson(List<ConnectionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConnectionsModel {
    ConnectionsModel({
        this.connectedWith,
        this.iAmSender,
        this.id,
        this.updatedAt,
        this.createdAt,
    });

    String? connectedWith;
    bool? iAmSender;
    String? id;
    DateTime? updatedAt;
    DateTime? createdAt;

    factory ConnectionsModel.fromJson(Map<String, dynamic> json) => ConnectionsModel(
        connectedWith: json["connected_with"],
        iAmSender: json["i_am_sender"],
        id: json["_id"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "connected_with": connectedWith,
        "i_am_sender": iAmSender,
        "_id": id,
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    };
}
