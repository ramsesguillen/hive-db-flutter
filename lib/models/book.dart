import 'package:meta/meta.dart';
import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    Book({
        @required this.id,
        @required this.bookId,
        @required this.book,
    });

    int id;
    int bookId;
    BookProps book;

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        bookId: json["book_id"],
        book: BookProps.fromJson(json["book"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "book": book.toJson(),
    };
}


class BookProps {
    BookProps({
        @required this.id,
        @required this.description,
        @required this.name,
        @required this.isbn,
        @required this.price,
        @required this.fileBookId,
        @required this.filePictureId,
    });

    int id;
    String description;
    String name;
    String isbn;
    String price;
    int fileBookId;
    int filePictureId;

    factory BookProps.fromJson(Map<String, dynamic> json) => BookProps(
        id: json["id"],
        description: json["description"],
        name: json["name"],
        isbn: json["isbn"],
        price: json["price"],
        fileBookId: json["file_book_id"],
        filePictureId: json["file_picture_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "name": name,
        "isbn": isbn,
        "price": price,
        "file_book_id": fileBookId,
        "file_picture_id": filePictureId,
    };
}

