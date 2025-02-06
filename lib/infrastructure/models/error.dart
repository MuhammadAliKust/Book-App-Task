// To parse this JSON data, do
//
//     final globalErrorModel = globalErrorModelFromJson(jsonString);

import 'dart:convert';

GlobalErrorModel globalErrorModelFromJson(String str) => GlobalErrorModel.fromJson(json.decode(str));

String globalErrorModelToJson(GlobalErrorModel data) => json.encode(data.toJson());

class GlobalErrorModel {
  final bool? status;
  final String? message;

  GlobalErrorModel({
    this.status,
    this.message,
  });

  factory GlobalErrorModel.fromJson(Map<String, dynamic> json) => GlobalErrorModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
