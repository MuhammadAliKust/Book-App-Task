import 'package:book_app/infrastructure/models/error.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/book.dart';

abstract class AuthRepository {
  Future<Either<GlobalErrorModel, User>> registerUser(
      {required String email, required String password});

  Future<Either<GlobalErrorModel, User>> loginUser(
      {required String email, required String password});

  Future<Either<GlobalErrorModel, dynamic>> resetPassword(
      {required String email});
}

class AuthRepositoryImp extends AuthRepository {
  @override
  Future<Either<GlobalErrorModel, User>> registerUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Right(userCredential.user!);
    } catch (e) {
      return Left(GlobalErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<GlobalErrorModel, User>> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(userCredential.user!);
    } catch (e) {
      return Left(GlobalErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<GlobalErrorModel, dynamic>> resetPassword(
      {required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right(true);
    } catch (e) {
      return Left(GlobalErrorModel(message: e.toString(), status: false));
    }
  }
}
