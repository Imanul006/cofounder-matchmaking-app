// To parse this JSON data, do
//
//     final cofounderListModel = cofounderListModelFromJson(jsonString);

import 'dart:convert';

import 'package:kiuqi/models/user_model.dart';

CofounderListModel cofounderListModelFromJson(String str) => CofounderListModel.fromJson(json.decode(str));

String cofounderListModelToJson(CofounderListModel data) => json.encode(data.toJson());

class CofounderListModel {
    CofounderListModel({
        this.totalPages,
        this.results,
    });

    int? totalPages;
    List<UserModel>? results;

    factory CofounderListModel.fromJson(Map<String, dynamic> json) => CofounderListModel(
        totalPages: json["totalPages"],
        results: json["results"] == null ? null : List<UserModel>.from(json["results"].map((x) => UserModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalPages": totalPages,
        "results": results == null ? null : List<UserModel>.from(results!.map((x) => x.toJson())),
    };
}

// class Result {
//     Result({
//         this.id,
//         this.phone,
//         this.v,
//         this.city,
//         this.dob,
//         this.email,
//         this.name,
//         this.profilePic,
//         this.state,
//         this.resume,
//         this.startup,
//     });

//     String? id;
//     String? phone;
//     int? v;
//     String? city;
//     DateTime? dob;
//     String? email;
//     String? name;
//     String? profilePic;
//     String? state;
//     Resume? resume;
//     Startup? startup;

//     factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json["_id"],
//         phone: json["phone"],
//         v: json["__v"],
//         city: json["city"],
//         dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         email: json["email"],
//         name: json["name"],
//         profilePic: json["profile_pic"],
//         state: json["state"],
//         resume: json["resume"] == null ? null : Resume.fromJson(json["resume"]),
//         startup: json["startup"] == null ? null : Startup.fromJson(json["startup"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "phone": phone,
//         "__v": v,
//         "city": city,
//         "dob": dob == null ? null : dob!.toIso8601String(),
//         "email": email,
//         "name": name,
//         "profile_pic": profilePic,
//         "state": state,
//         "resume": resume == null ? null : resume!.toJson(),
//         "startup": startup == null ? null : startup!.toJson(),
//     };
// }

// class Resume {
//     Resume({
//         this.bio,
//         this.category,
//         this.expertise,
//         this.startupCount,
//         this.skills,
//         this.hasStartup,
//         this.id,
//     });

//     String? bio;
//     String? category;
//     String? expertise;
//     int? startupCount;
//     String? skills;
//     bool? hasStartup;
//     String? id;

//     factory Resume.fromJson(Map<String, dynamic> json) => Resume(
//         bio: json["bio"],
//         category: json["category"],
//         expertise: json["expertise"],
//         startupCount: json["startup_count"],
//         skills: json["skills"],
//         hasStartup: json["has_startup"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "bio": bio,
//         "category": category,
//         "expertise": expertise,
//         "startup_count": startupCount,
//         "skills": skills,
//         "has_startup": hasStartup,
//         "_id": id,
//     };
// }

// class Startup {
//     Startup({
//         this.name,
//         this.legalName,
//         this.tagline,
//         this.industry,
//         this.dateFounded,
//         this.kvIncubationId,
//         this.id,
//     });

//     String? name;
//     String? legalName;
//     String? tagline;
//     String? industry;
//     DateTime? dateFounded;
//     String? kvIncubationId;
//     String? id;

//     factory Startup.fromJson(Map<String, dynamic> json) => Startup(
//         name: json["name"],
//         legalName: json["legal_name"],
//         tagline: json["tagline"],
//         industry: json["industry"],
//         dateFounded: json["date_founded"] == null ? null : DateTime.parse(json["date_founded"]),
//         kvIncubationId: json["kv_incubation_id"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//         "legal_name": legalName,
//         "tagline": tagline,
//         "industry": industry,
//         "date_founded": dateFounded == null ? null : dateFounded!.toIso8601String(),
//         "kv_incubation_id": kvIncubationId,
//         "_id": id,
//     };
// }
