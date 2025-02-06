import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../application/connectivity_status.dart';
import '../configs/backend.dart';
import 'models/error.dart';

var logger = Logger();

class ApiBaseHelper {
  Future<Either<GlobalErrorModel, dynamic>> getEither(
      {required String endPoint,
      required bool isRequiredHeader,
      Map<String, String>? header}) async {
    DateTime executionTime = DateTime.now();
    // ignore: prefer_typing_uninitialized_variables
    Either<GlobalErrorModel, dynamic> responseJson;
    try {
      return await InternetConnectivityHelper.checkConnectivity()
          .then((value) async {
        if (value == true) {
          final response = await http.get(
              Uri.parse(BackendConfigs.kBaseURL + endPoint),
              headers: isRequiredHeader ? header! : null);
          responseJson = _returnResponseEither(response);
          logger.i(
              "BaseUrl -> ${BackendConfigs.kBaseURL} || EndPoints -> $endPoint || Status Code -> ${response.statusCode.toString()} || Response Time: ${DateTime.now().difference(executionTime).inMilliseconds} ms");
          return responseJson.fold((l) => Left(l), (r) => Right(r));
        } else {
          return Left(GlobalErrorModel(
              message:
                  "Oops! It seems you are not connected to the internet."));
        }
      });
    } on SocketException catch (e) {
      logger.i("Socket Exception");
      logger.e(e.message.toString());
      return Left(GlobalErrorModel(
          message:
              "Some of our servers are undergoing maintenance. If you are currently facing difficulty in connecting, kindly wait a little and retry." +
                  "\nSorry for the inconvenience."));
    } on HttpException catch (e) {
      logger.i("HTTP Exception");
      logger.e(e.message.toString());
      return Left(GlobalErrorModel(
          message: "Sorry! We are unable to complete your request.!"));
    } on TimeoutException catch (e) {
      logger.i("TimeOut Exception");
      logger.e(e.message.toString());
      return Left(GlobalErrorModel(
          message: "Sorry! We are unable to connect our servers.!"));
    } catch (e) {
      return Left(GlobalErrorModel(message: "Something went wrong."));
    }
  }

  Future<Either<GlobalErrorModel, dynamic>> postEither(
      {required String endPoint,
      required bool isRequiredHeader,
      required bool hasBody,
      dynamic body,
      Map<String, String>? header}) async {
    DateTime executionTime = DateTime.now();
    // ignore: prefer_typing_uninitialized_variables
    Either<GlobalErrorModel, dynamic> responseJson;
    try {
      return await InternetConnectivityHelper.checkConnectivity()
          .then((value) async {
        if (value == true) {
          final response = await http.post(
              Uri.parse(BackendConfigs.kBaseURL + endPoint),
              headers: isRequiredHeader ? header! : null,
              body: hasBody == true ? jsonEncode(body) : null);
          responseJson = _returnResponseEither(response);
          logger.i(
              "BaseUrl -> ${BackendConfigs.kBaseURL} || EndPoints -> $endPoint || Status Code -> ${response.statusCode.toString()} || Response Time: ${DateTime.now().difference(executionTime).inMilliseconds} ms");
          return responseJson.fold((l) => Left(l), (r) => Right(r));
        } else {
          return Left(GlobalErrorModel(
              message:
                  "Oops! It seems you are not connected to the internet."));
        }
      });
    } on SocketException catch (e) {
      logger.i("Socket Exception");
      logger.e(e.message.toString());
      return Left(GlobalErrorModel(
          message:
              "Some of our servers are undergoing maintenance. If you are currently facing difficulty in connecting, kindly wait a little and retry." +
                  "\nSorry for the inconvenience."));
    } on HttpException catch (e) {
      logger.i("HTTP Exception");
      logger.e(e.message.toString());
      return Left(GlobalErrorModel(
          message: "Sorry! We are unable to complete your request.!"));
    } on TimeoutException catch (e) {
      logger.i("TimeOut Exception");
      logger.e(e.message.toString());
      return Left(GlobalErrorModel(
          message: "Sorry! We are unable to connect our servers.!"));
    } catch (e) {
      return Left(GlobalErrorModel(message: "Something went wrong."));
    }
  }

  Future<Either<GlobalErrorModel, dynamic>> deleteEither(
      {required String endPoint,
      required bool isRequiredHeader,
      required bool hasBody,
      dynamic body,
      Map<String, String>? header}) async {
    DateTime executionTime = DateTime.now();
    // ignore: prefer_typing_uninitialized_variables
    Either<GlobalErrorModel, dynamic> responseJson;
    try {
      return await InternetConnectivityHelper.checkConnectivity()
          .then((value) async {
        if (value == true) {
          final response = await http.delete(
              Uri.parse(BackendConfigs.kBaseURL + endPoint),
              headers: isRequiredHeader ? header! : null,
              body: hasBody == true ? jsonEncode(body) : null);
          responseJson = _returnResponseEither(response);
          logger.i(
              "BaseUrl -> ${BackendConfigs.kBaseURL} || EndPoints -> $endPoint || Status Code -> ${response.statusCode.toString()} || Response Time: ${DateTime.now().difference(executionTime).inMilliseconds} ms");
          return responseJson.fold((l) => Left(l), (r) => Right(r));
        } else {
          return Left(GlobalErrorModel(
              message:
                  "Oops! It seems you are not connected to the internet."));
        }
      });
    } on SocketException catch (e) {
      logger.i("Socket Exception");
      logger.e(e.message.toString());
      return Left(GlobalErrorModel(
          message:
              "Some of our servers are undergoing maintenance. If you are currently facing difficulty in connecting, kindly wait a little and retry." +
                  "\nSorry for the inconvenience."));
    } on HttpException catch (e) {
      logger.i("HTTP Exception");
      logger.e(e.message.toString());
      return Left(GlobalErrorModel(
          message: "Sorry! We are unable to complete your request.!"));
    } on TimeoutException catch (e) {
      logger.i("TimeOut Exception");
      logger.e(e.message.toString());
      return Left(GlobalErrorModel(
          message: "Sorry! We are unable to connect our servers.!"));
    } catch (e) {
      return Left(GlobalErrorModel(message: "Something went wrong."));
    }
  }

  Future<Either<GlobalErrorModel, dynamic>> postMultiPartEither(
      {required String endPoint,
      required bool isRequiredHeader,
      required bool hasBody,
      String? path,
      required bool hasFile,
      dynamic body,
      Map<String, String>? header}) async {
    DateTime executionTime = DateTime.now();
    // ignore: prefer_typing_uninitialized_variables
    Either<GlobalErrorModel, dynamic> responseJson;
    try {
      return await InternetConnectivityHelper.checkConnectivity()
          .then((value) async {
        if (value == true) {
          var request = http.MultipartRequest(
              'POST', Uri.parse(BackendConfigs.kBaseURL + endPoint));
          request.fields.addAll(body);
          request.headers.addAll(header!);
          if (hasFile) {
            request.files.add(await http.MultipartFile.fromPath('file', path!));
          }
          http.StreamedResponse streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse);

          responseJson = _returnResponseEither(response);

          logger.i(
              "BaseUrl -> ${BackendConfigs.kBaseURL} || EndPoints -> $endPoint || Status Code -> ${response.statusCode.toString()} || ${DateTime.now()}");

          return responseJson.fold((l) => Left(l), (r) => Right(r));
        } else {
          return Left(GlobalErrorModel(
              message:
                  "Oops! It seems you are not connected to the internet."));
        }
      });
    } on SocketException catch (e) {
      logger.i("Socket Exception");
      logger.e(e.message.toString());
      return Left(GlobalErrorModel(
          message:
              "Some of our servers are undergoing maintenance. If you are currently facing difficulty in connecting, kindly wait a little and retry." +
                  "\nSorry for the inconvenience."));
    } on HttpException catch (e) {
      logger.i("HTTP Exception");
      logger.e(e.message.toString());
      return Left(GlobalErrorModel(
          message: "Sorry! We are unable to complete your request.!"));
    } on TimeoutException catch (e) {
      logger.i("TimeOut Exception");
      logger.e(e.message.toString());
      return Left(GlobalErrorModel(
          message: "Sorry! We are unable to connect our servers.!"));
    } catch (e) {
      return Left(GlobalErrorModel(message: "Something went wrong."));
    }
  }

  Either<GlobalErrorModel, dynamic> _returnResponseEither(
      http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseJson = json.decode(response.body.toString());
      return Right(responseJson);
    } else if (response.statusCode == 400) {
      return Left(GlobalErrorModel(message: "Bad Request"));
    } else if (response.statusCode == 401) {
      return Left(GlobalErrorModel(
          message: "Sorry! You are not allowed to perform this operation.!"));
    } else if (response.statusCode == 404) {
      return Left(
          GlobalErrorModel(message: "Sorry! Your requested data not found!"));
    } else if (response.statusCode == 500) {
      log(response.reasonPhrase.toString());
      return Left(GlobalErrorModel(
          message: "Sorry! We are facing some internal connection issues.!"));
    } else if (response.statusCode == 503) {
      return Left(GlobalErrorModel(
          message: "Sorry! We are facing some issues in connection.!"));
    } else {
      return Left(GlobalErrorModel(message: "Sorry! Some thing went wrong!."));
    }
  }
}
