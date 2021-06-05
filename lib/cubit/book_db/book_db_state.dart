part of 'book_db_cubit.dart';

@immutable
abstract class BookDbState {}

class BookDbInitial extends BookDbState {}

class BookListLoading extends BookDbInitial {}

class BookListLoaded extends BookDbInitial {
  final List<Book> book;
  BookListLoaded( this.book );
}

class DownloadBookError extends BookDbInitial {
  final String message;
  DownloadBookError( this.message );
}
