import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:hive/hive.dart';
import 'package:hive_db/cubit/book_db/book_db_cubit.dart';
// import 'package:hive_db/models/book.dart';
import 'package:hive_db/new_book_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'new_contact_form.dart';


class BoookService {

  static Future<String> getCover( int id ) async {

    /// Hacer la peticion y obtener el cover

    /// Inserta en la db
    Hive.box('prueba').put('cover-${id.toString() }', 'PORTADA DEL LIBRO ${id.toString()}');
    var box = Hive.box('prueba');

    // print( box.isEmpty );
    // print( box.containsKey('cover-1') );

    /// Devuelve el cover
    return box.get('cover-${id.toString() }');
    // return 'data';
  }
}

class BookPage extends StatelessWidget {
  const BookPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<BookDbCubit>().getBookList();
    return Scaffold(
        appBar: AppBar(
          title: Text('Hive Tutorial'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              BlocBuilder<BookDbCubit, BookDbState>(
                builder: (context, state) {
                  if ( state is BookListLoading ) {
                    return Container(
                        width: 270.0,
                        height: 230.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('cargando...')],
                        )
                      );
                  } else if ( state is BookListLoaded ) {
                    return Flexible(
                      child: ListView.builder(
                        itemCount: state.book.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Column(
                              children: [
                                Text( state.book[index].book.name),
                                FutureBuilder(
                                  future: BoookService.getCover(state.book[index].bookId),
                                  // initialData: InitialData,
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      // print( snapshot.data );
                                      return Text(snapshot.data);
                                      // return Text('cargado');
                                    } else {
                                      return Text('Cargando...');
                                    }
                                  },
                                ),
                              ],
                            )
                          );
                        },
                      ),
                    );
                  } else if ( state is BookDbInitial ) {
                    return Text('Presiona el boton para cargar los libros');
                  } else {
                    return Text('Error');
                  }
                },
              ),
              NewBookForm(),
            ],
          ),
        ));
  }

}