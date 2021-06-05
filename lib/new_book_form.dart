import 'package:flutter/material.dart';
import 'package:hive_db/cubit/book_db/book_db_cubit.dart';
import 'package:hive_db/models/book.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// import 'models/contact.dart';

class NewBookForm extends StatefulWidget {
  @override
  _NewBookFormState createState() => _NewBookFormState();
}

class _NewBookFormState extends State<NewBookForm> {
  final _formKey = GlobalKey<FormState>();

  // BookProps book = new ;

  String _name;
  // String _age;

  void addBook(List<Book> books) {
    context.read<BookDbCubit>().setBook( books ); /// No aplica en la paliación real
    context.read<BookDbCubit>().getBookList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Add New Book'),
            onPressed: () {
              final List<Book> listBook = [
                Book(
                  book: BookProps(
                    id: 1,
                    description: 'description 2 222 2 2 ',
                    name: 'Historia de Mexico',
                    isbn: 'isbn',
                    price: 'price',
                    fileBookId: 1,
                    filePictureId: 1
                  ),
                  bookId: 1,
                  id: 1
                ),
                Book(
                  book: BookProps(
                    id: 2,
                    description: 'description 2 222 2 2 ',
                    name: 'Calculo Integral',
                    isbn: 'isbn',
                    price: 'price',
                    fileBookId: 2,
                    filePictureId: 2,
                  ),
                  bookId: 2,
                  id: 2
                ),
                Book(
                  book: BookProps(
                    id: 3,
                    description: 'description 2 222 2 2 ',
                    name: 'Programación Orientada a Objetos',
                    isbn: 'isbn',
                    price: 'price',
                    fileBookId: 3,
                    filePictureId: 3
                  ),
                  bookId: 3,
                  id: 4
                ),
              ];
              _formKey.currentState.save();
              addBook( listBook );
            },
          ),
        ],
      ),
    );
  }
}