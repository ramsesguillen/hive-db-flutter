import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_db/cubit/book_db/book_db_cubit.dart';
import 'package:hive_db/db/book_db.dart';
import 'package:path_provider/path_provider.dart';

import 'contact_page.dart';

void main() async {
  // Se crea la DB
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init( appDocDir.path );
  runApp(MyApp());

  // final bookBox = await Hive.openBox('books');

}

class MyApp extends StatelessWidget {
  final db = BooKDB();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BookDbCubit() )
      ],
      child: MaterialApp(
        title: 'Hive Tutorial',
        home: FutureBuilder(
          // future: Hive.openBox('books'), // Se crea la tabla
          future: db.initDB(), // Se crea la tabla
          // initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if ( snapshot.connectionState == ConnectionState.done ) {
              if ( snapshot.hasError ) {
                return Text(snapshot.error.toString() );
              } else {
                return BookPage();
              }
            }
            return Scaffold();
          },
        ),
        // home: BookPage(),
      )
    );
  }
}

