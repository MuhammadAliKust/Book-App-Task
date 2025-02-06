import 'package:book_app/configs/backend.dart';
import 'package:book_app/infrastructure/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../models/error.dart';

abstract class UserRepository {
  Future<Either<GlobalErrorModel, dynamic>> createUser(UserModel model);

  Future<Either<GlobalErrorModel, UserModel>> getUserByID(String userID);

  Future<Either<GlobalErrorModel, dynamic>> updateUser(UserModel model);
}

class UserRepositoryImp extends UserRepository {
  ///Create User Account
  @override
  Future<Either<GlobalErrorModel, dynamic>> createUser(UserModel model) async {
    try {
      await FirebaseFirestore.instance
          .collection(BackendConfigs.kUser)
          .doc(model.docId)
          .set(model.toJson(model.docId.toString()));
      return const Right(true);
    } catch (e) {
      return Left(GlobalErrorModel(status: false, message: e.toString()));
    }
  }

  ///Update User Profile
  @override
  Future<Either<GlobalErrorModel, dynamic>> updateUser(UserModel model) async {
    try {
      await FirebaseFirestore.instance
          .collection(BackendConfigs.kUser)
          .doc(model.docId)
          .update({"name": model.name});
      return const Right(true);
    } catch (e) {
      return Left(GlobalErrorModel(status: false, message: e.toString()));
    }
  }

  ///Get User Details
  @override
  Future<Either<GlobalErrorModel, UserModel>> getUserByID(String userID) async {
    try {
      return await FirebaseFirestore.instance
          .collection(BackendConfigs.kUser)
          .doc(userID)
          .get()
          .then((model) => Right(UserModel.fromJson(model.data()!)));
    } catch (e) {
      return Left(GlobalErrorModel(status: false, message: e.toString()));
    }
  }
}
