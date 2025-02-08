import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:book_app/configs/backend.dart';
import 'package:book_app/infrastructure/models/book.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../api_helper.dart';
import '../models/error.dart';

abstract class BookRepository {
  Future<Either<GlobalErrorModel, BookListingModel>> getAllBooks();

  Future<Either<GlobalErrorModel, BookListingModel>> searchBook(
      String searchKey);
}

class BookRepositoryImp extends BookRepository {
  ///Get All Books
  @override
  Future<Either<GlobalErrorModel, BookListingModel>> getAllBooks() async {
    var data = await ApiBaseHelper().getEither(
      endPoint: BackendConfigs.kGetBooks,
      isRequiredHeader: false,
    );
    return data.fold(
        (l) => Left(GlobalErrorModel(message: l.message.toString())),
        (r) => Right(BookListingModel.fromJson(r)));
  }

  ///Search Books
  @override
  Future<Either<GlobalErrorModel, BookListingModel>> searchBook(
      String searchKey) async {
    var data = await ApiBaseHelper().getEither(
        endPoint: "${BackendConfigs.kSearchBooks}?title=$searchKey",
        isRequiredHeader: false);
    return data.fold(
        (l) => Left(GlobalErrorModel(message: l.message.toString())),
        (r) => Right(BookListingModel.fromJson(r)));
  }
}
