// To parse this JSON data, do
//
//     final resetPasswordResModel = resetPasswordResModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordResModel resetPasswordResModelFromJson(String str) =>
    ResetPasswordResModel.fromJson(json.decode(str));

String resetPasswordResModelToJson(ResetPasswordResModel data) =>
    json.encode(data.toJson());

class ResetPasswordResModel {
  ResetPasswordResModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory ResetPasswordResModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordResModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
