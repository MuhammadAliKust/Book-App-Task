import 'dart:developer';

import 'package:book_app/application/auth_bloc/auth_bloc.dart';
import 'package:book_app/application/book_bloc/book_bloc.dart';
import 'package:book_app/application/cart_bloc/cart_bloc.dart';
import 'package:book_app/infrastructure/services/auth.dart';
import 'package:book_app/infrastructure/services/book.dart';
import 'package:book_app/infrastructure/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Blocs
  sl.registerFactory<BookBloc>(() => BookBloc(sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(),sl()));
  sl.registerFactory<CartBloc>(() => CartBloc(sl()));

  ///Services
  sl.registerLazySingleton(() => BookRepositoryImp());
  sl.registerLazySingleton(() => AuthRepositoryImp());
  sl.registerLazySingleton(() => UserRepositoryImp());


  ///Utils
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);
}
