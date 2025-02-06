// To parse this JSON data, do
//
//     final bookListingModel = bookListingModelFromJson(jsonString);

import 'dart:convert';

BookListingModel bookListingModelFromJson(String str) =>
    BookListingModel.fromJson(json.decode(str));

String bookListingModelToJson(BookListingModel data) =>
    json.encode(data.toJson());

class BookListingModel {
  final bool? status;
  final String? message;
  final List<BookModel>? data;

  BookListingModel({
    this.status,
    this.message,
    this.data,
  });

  factory BookListingModel.fromJson(Map<String, dynamic> json) =>
      BookListingModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<BookModel>.from(
                json["data"]!.map((x) => BookModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BookModel {
  final int? id;
  final Author? author;
  final String? title;
  final String? coverImage;
  final int? pages;
  final String? releaseDate;

  BookModel({
    this.id,
    this.author,
    this.title,
    this.coverImage,
    this.pages,
    this.releaseDate,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["id"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        title: json["title"],
        coverImage: json["cover_image"],
        pages: json["pages"],
        releaseDate: json["releaseDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author?.toJson(),
        "title": title,
        "cover_image": coverImage,
        "pages": pages,
        "releaseDate": releaseDate,
      };
}

class Author {
  final String? id;
  final String? name;

  Author({
    this.id,
    this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
