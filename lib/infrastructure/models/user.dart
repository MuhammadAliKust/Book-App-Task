// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) =>
    json.encode(data.toJson(data.docId.toString()));

class UserModel {
  final String? docId;
  final String? name;
  final String? email;
  final int? createdAt;

  UserModel({
    this.docId,
    this.name,
    this.email,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        docId: json["docID"],
        name: json["name"],
        email: json["email"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "docID": docID,
        "name": name,
        "email": email,
        "createdAt": createdAt,
      };
}
