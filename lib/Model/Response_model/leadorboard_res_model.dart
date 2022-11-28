// To parse this JSON data, do
//
//     final leaderboardResponseModel = leaderboardResponseModelFromJson(jsonString);

import 'dart:convert';

LeaderboardResponseModel leaderboardResponseModelFromJson(String str) =>
    LeaderboardResponseModel.fromJson(json.decode(str));

String leaderboardResponseModelToJson(LeaderboardResponseModel data) =>
    json.encode(data.toJson());

class LeaderboardResponseModel {
  LeaderboardResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory LeaderboardResponseModel.fromJson(Map<String, dynamic> json) =>
      LeaderboardResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.today,
    this.monthly,
  });

  List<Monthly>? today;
  List<Monthly>? monthly;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        today:
            List<Monthly>.from(json["today"].map((x) => Monthly.fromJson(x))),
        monthly:
            List<Monthly>.from(json["Monthly"].map((x) => Monthly.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "today": List<dynamic>.from(today!.map((x) => x.toJson())),
        "Monthly": List<dynamic>.from(monthly!.map((x) => x.toJson())),
      };
}

class Monthly {
  Monthly({
    this.userId,
    this.coins,
    this.profilePic,
    this.name,
    this.username,
    this.level,
  });

  String? userId;
  String? coins;
  String? profilePic;
  String? name;
  String? username;
  String? level;

  factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
        userId: json["user_id"],
        coins: json["coins"],
        profilePic: json["profile_pic"],
        name: json["name"],
        username: json["username"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "coins": coins,
        "profile_pic": profilePic,
        "name": name,
        "username": username,
        "level": level,
      };
}
