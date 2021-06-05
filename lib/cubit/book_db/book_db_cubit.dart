import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_db/models/book.dart';
import 'package:meta/meta.dart';

part 'book_db_state.dart';

class BookDbCubit extends Cubit<BookDbState> {
  BookDbCubit() : super(BookDbInitial());


  Future<void> getBookList() async {
    final currentState = state;
    if ( currentState is BookDbInitial ) {

      emit( BookListLoading() );

      /// books: Nombre de la tabla
      var box = Hive.box('books');

      /// mando a llamar por la llave
      /// La lleve deberia ser el book-$idusario
      /// Para poder filtrar los libros de distintos usuarios
      /// Porque el usuario puede ingresar con distintas cuentas
      /// books: Nombre del key
      final bookAsString = box.get('books');
      List<Book> books = bookFromJson( bookAsString );

      if ( books != null ) {
        emit( BookListLoaded( books ) );
      } else {
        emit( DownloadBookError('No hay informacion de libros') );
      }
    }
  }

  Future<void> setBook( List<Book> books ) async {
    final bookAsString = bookToJson( books );
    Hive.box('books').put('books', bookAsString);
    emit( BookDbInitial() );
  }

  /// Todo: Crear un Box - covers
  /// Cuardar los covers por keys
  /// cada id de libro será un key
  /// Dentro del Future se hará el insert y el get de los covers


}
