part of 'book_bloc.dart';

@immutable
abstract class BookEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetBooksEvent extends BookEvents {
  GetBooksEvent();
}

class SearchBookEvent extends BookEvents {
  final String searchKey;

  SearchBookEvent(this.searchKey);
}
