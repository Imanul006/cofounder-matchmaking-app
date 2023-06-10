// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.id,
        this.phone,
        this.city,
        this.dob,
        this.email,
        this.name,
        this.profilePic,
        this.state,
        this.resume,
        this.startup,
    });

    String? id;
    String? phone;
    String? city;
    DateTime? dob;
    String? email;
    String? name;
    String? profilePic;
    String? state;
    Resume? resume;
    Startup? startup;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        phone: json["phone"],
        city: json["city"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        email: json["email"],
        name: json["name"],
        profilePic: json["profile_pic"],
        state: json["state"],
        resume: json["resume"] == null ? null : Resume.fromJson(json["resume"]),
        startup: json["startup"] == null ? null : Startup.fromJson(json["startup"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
        "city": city,
        "dob": dob == null ? null : dob!.toIso8601String(),
        "email": email,
        "name": name,
        "profile_pic": profilePic,
        "state": state,
        "resume": resume == null ? null : resume!.toJson(),
        "startup": startup == null ? null : startup!.toJson(),
    };
}

class Resume {
    Resume({
        this.bio,
        this.category,
        this.expertise,
        this.startupCount,
        this.skills,
        this.hasStartup,
        this.id,
    });

    String? bio;
    String? category;
    String? expertise;
    int? startupCount;
    String? skills;
    bool? hasStartup;
    String? id;

    factory Resume.fromJson(Map<String, dynamic> json) => Resume(
        bio: json["bio"],
        category: json["category"],
        expertise: json["expertise"],
        startupCount: json["startup_count"],
        skills: json["skills"],
        hasStartup: json["has_startup"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "bio": bio,
        "category": category,
        "expertise": expertise,
        "startup_count": startupCount,
        "skills": skills,
        "has_startup": hasStartup,
        "_id": id,
    };
}

class Startup {
    Startup({
        this.name,
        this.legalName,
        this.tagline,
        this.industry,
        this.dateFounded,
        this.kvIncubationId,
        this.id,
    });

    String? name;
    String? legalName;
    String? tagline;
    String? industry;
    DateTime? dateFounded;
    String? kvIncubationId;
    String? id;

    factory Startup.fromJson(Map<String, dynamic> json) => Startup(
        name: json["name"],
        legalName: json["legal_name"],
        tagline: json["tagline"],
        industry: json["industry"],
        dateFounded: json["date_founded"] == null ? null : DateTime.parse(json["date_founded"]),
        kvIncubationId: json["kv_incubation_id"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "legal_name": legalName,
        "tagline": tagline,
        "industry": industry,
        "date_founded": dateFounded == null ? null : dateFounded?.toIso8601String(),
        "kv_incubation_id": kvIncubationId,
        "_id": id,
    };
}
