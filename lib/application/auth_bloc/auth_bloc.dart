import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:book_app/infrastructure/models/book.dart';
import 'package:book_app/infrastructure/models/user.dart';
import 'package:book_app/infrastructure/services/book.dart';
import 'package:book_app/infrastructure/services/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../infrastructure/services/auth.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final AuthRepositoryImp repositoryImp;
  final UserRepositoryImp userRepositoryImp;

  AuthBloc(this.repositoryImp, this.userRepositoryImp) : super(AuthInitial()) {
    on<AuthEvents>((event, emit) async {
      emit(AuthLoading());

      if (event is LoginEvent) {
        try {
          final failureOrSuccess = await repositoryImp.loginUser(
              email: event.email, password: event.pwd);

          failureOrSuccess.fold((l) => emit(AuthFailed(l.message.toString())),
              (r) {
            return emit(LoggedIn(r.uid));
          });
        } catch (e) {
          emit(const AuthFailed('An undefined error occurred.'));
        }
      } else if (event is RegisterEvent) {
        try {
          final failureOrSuccess = await repositoryImp.registerUser(
              email: event.email, password: event.pwd);

          failureOrSuccess.fold((l) => emit(AuthFailed(l.message.toString())),
              (r) {
            return emit(Registered(r.uid));
          });
        } catch (e) {
          emit(const AuthFailed('An undefined error occurred.'));
        }
      } else if (event is ForgotPasswordEvent) {
        try {
          final failureOrSuccess =
              await repositoryImp.resetPassword(email: event.email.toString());

          failureOrSuccess.fold((l) => emit(AuthFailed(l.message.toString())),
              (r) {
            return emit(const ResetPwdEmailSent());
          });
        } catch (e) {
          emit(const AuthFailed('An undefined error occurred.'));
        }
      } else if (event is CreateUserProfileEvent) {
        try {
          final failureOrSuccess = await userRepositoryImp.createUser(UserModel(
              docId: event.docID,
              name: event.name,
              email: event.email,
              createdAt: DateTime.now().millisecondsSinceEpoch));

          failureOrSuccess.fold((l) => emit(AuthFailed(l.message.toString())),
              (r) {
            return emit(const UserProfileCreated());
          });
        } catch (e) {
          emit(const AuthFailed('An undefined error occurred.'));
        }
      }
    });
  }
}
