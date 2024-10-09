import 'dart:convert';

import 'package:book_log/models/book.dart';
import 'package:http/http.dart' as http;

class BookController {
  BookController();

Future<List<Book>> getBooks() async {
  List<Book> bookReturn = [];
    final response = await http.get(Uri.parse('https://api.itbook.store/1.0/new'));
    if (response.statusCode == 200) {
      final books = json.decode(response.body);
      for (var book in books['books']) {
        print(book['isbn13']);
        final booksResponse = await http.get(Uri.parse('https://api.itbook.store/1.0/books/${book['isbn13']}'));
        if (booksResponse.statusCode == 200) {
          final book = Book.fromJson(json.decode(booksResponse.body));
          bookReturn.add(book);
          print(book.toJson());
        } else {
          throw Exception('Failed to load book');
        }
    }
    } else {
      throw Exception('Failed to load books');
    }
    return bookReturn;
  }

  void addBook() {
    //TODO Add code here for addBook
  }

  void editBook() {
    //TODO Add code here for editBook
  }

  void deleteBook() {
    //TODO Add code here for deleteBook
  }

  void getBook() {
    //TODO Add code here for getBook
  }

  void addBooks() {
    //TODO Add code here for addBooks
  }

  void editBooks() {
    //TODO Add code here for editBooks
  }

  void deleteBooks() {
    //TODO Add code here for deleteBooks
  }

  void getBooksByCategory() {
    //TODO Add code here for getBooksByCategory
  }

  void getBooksByAuthor() {
    //TODO Add code here for getBooksByAuthor
  }

  void getBooksByPublisher() {
    //TODO Add code here for getBooksByPublisher
  }

  void getBooksByPrice() {
    //TODO Add code here for getBooksByPrice
  }

  void getBooksByRating() {
    //TODO Add code here for getBooksByRating
  }

  void getBooksByLanguage() {
    //TODO Add code here for getBooksByLanguage
  }

  void getBooksByIsbn() {
    //TODO Add code here for getBooksByIsbn
  }

  void getBooksByPages() {
    //TODO Add code here for getBooksByPages
  }

  void getBooksByCategories() {
    //TODO Add code here for getBooksByCategories
  }

  void getBooksByDescription() {
    //TODO Add code here for getBooksByDescription
  }

  void getBooksByTitle() {
    //TODO Add code here for getBooksByTitle
  }


  void getBooksById() {
    //TODO Add code here for getBooksById
  }



}