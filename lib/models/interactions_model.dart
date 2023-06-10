// To parse this JSON data, do
//
//     final interactionsModel = interactionsModelFromJson(jsonString);

import 'dart:convert';

List<InteractionsModel> interactionsModelFromJson(String str) => List<InteractionsModel>.from(json.decode(str).map((x) => InteractionsModel.fromJson(x)));

String interactionsModelToJson(List<InteractionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InteractionsModel {
    InteractionsModel({
        this.interactionType,
        this.interactedWith,
        this.id,
        this.updatedAt,
        this.createdAt,
    });

    String? interactionType;
    String? interactedWith;
    String? id;
    DateTime? updatedAt;
    DateTime? createdAt;

    factory InteractionsModel.fromJson(Map<String, dynamic> json) => InteractionsModel(
        interactionType: json["interaction_type"],
        interactedWith: json["interacted_with"],
        id: json["_id"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "interaction_type": interactionType,
        "interacted_with": interactedWith,
        "_id": id,
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    };
}
