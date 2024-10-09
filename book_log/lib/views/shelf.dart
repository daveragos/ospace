import 'package:book_log/controllers/book_controller.dart';
import 'package:book_log/models/book.dart';
import 'package:flutter/material.dart';

class Shelf extends StatefulWidget {
  const Shelf({super.key});

  @override
  State<Shelf> createState() => _ShelfState();
}

class _ShelfState extends State<Shelf> {

  List<Book> _books = [];

  Future<void> getBooks() async {
      _books = await BookController().getBooks();
  }

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            itemCount: _books.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_books[index].title),
                subtitle: Text(_books[index].subtitle),
                trailing: Text(_books[index].authors),
              );
            },
          );
  }

}