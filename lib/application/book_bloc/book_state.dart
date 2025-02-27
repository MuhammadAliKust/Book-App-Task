part of 'book_bloc.dart';

@immutable
abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final BookListingModel model;

  const BookLoaded(this.model);
}

class BookFailed extends BookState {
  final String message;

  const BookFailed(this.message);
}
