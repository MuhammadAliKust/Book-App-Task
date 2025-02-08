// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

List<CartModel> cartModelFromJson(String? str) =>
    List<CartModel>.from(json.decode(str!).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  String name;
  String id;
  String price;
  String image;
  int quantity;

  CartModel({
    required this.name,
    required this.id,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        name: json["name"],
        id: json["id"],
        price: json["price"],
        image: json["image"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "price": price,
        "image": image,
        "quantity": quantity,
      };
}
