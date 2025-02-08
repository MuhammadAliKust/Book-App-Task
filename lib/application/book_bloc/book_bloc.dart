import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:book_app/infrastructure/models/book.dart';
import 'package:book_app/infrastructure/services/book.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_event.dart';

part 'book_state.dart';

class BookBloc extends Bloc<BookEvents, BookState> {
  final BookRepositoryImp repositoryImp;

  BookBloc(this.repositoryImp) : super(BookInitial()) {
    on<BookEvents>((event, emit) async {
      emit(BookLoading());

      if (event is GetBooksEvent) {
        try {
          final failureOrSuccess = await repositoryImp.getAllBooks();

          failureOrSuccess.fold((l) => emit(BookFailed(l.message.toString())),
              (r) {
            return emit(BookLoaded(r));
          });
        } catch (e) {
          emit(const BookFailed('An undefined error occurred.'));
        }
      } else if (event is SearchBookEvent) {
        try {
          final failureOrSuccess =
              await repositoryImp.searchBook(event.searchKey.toString());

          failureOrSuccess.fold((l) => emit(BookFailed(l.message.toString())),
              (r) {
            return emit(BookLoaded(r));
          });
        } catch (e) {
          emit(const BookFailed('An undefined error occurred.'));
        }
      }
    });
  }
}
