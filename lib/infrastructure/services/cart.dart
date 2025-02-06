import 'package:book_app/infrastructure/models/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../configs/backend.dart';
import '../models/book.dart';
import '../models/error.dart';

abstract class CartRepository {
  Future<Either<GlobalErrorModel, dynamic>> addItemToCart(ItemModel model);

  Future<Either<GlobalErrorModel, dynamic>> removeItemFromCart(ItemModel model);

  Future<Either<GlobalErrorModel, dynamic>> incrementQuantity(ItemModel model);

  Future<Either<GlobalErrorModel, dynamic>> decrementQuantity(ItemModel model);

  Future<Either<GlobalErrorModel, CartModel>> getCartByUserID(String userID);

  Future<Either<GlobalErrorModel, dynamic>> emptyCart(String userID);

  Future<Either<GlobalErrorModel, dynamic>> getCartTotal(String userID);
}

class CartRepositoryImp extends CartRepository {
  @override
  Future<Either<GlobalErrorModel, dynamic>> addItemToCart(
      ItemModel model) async {
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

  @override
  Future<Either<GlobalErrorModel, dynamic>> decrementQuantity(
      ItemModel model) async {
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

  @override
  Future<Either<GlobalErrorModel, dynamic>> emptyCart(String userID) async {
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

  @override
  Future<Either<GlobalErrorModel, CartModel>> getCartByUserID(
      String userID) async {
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

  @override
  Future<Either<GlobalErrorModel, dynamic>> getCartTotal(String userID) async {
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

  @override
  Future<Either<GlobalErrorModel, dynamic>> incrementQuantity(
      ItemModel model) async {
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

  @override
  Future<Either<GlobalErrorModel, dynamic>> removeItemFromCart(
      ItemModel model) async {
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
}
