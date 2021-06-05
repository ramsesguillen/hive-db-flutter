



import 'package:hive/hive.dart';
import 'package:hive_db/models/book.dart';

class BooKDB {

  Future initDB() async {
    await Hive.openBox('books');
    await Hive.openBox('prueba');
  }

  insert( Book book ) async {

  }

  Future<List<Book>> getListBook() async {

  }


}