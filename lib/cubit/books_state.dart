import '../api/api.dart';

abstract class BooksState {
  final List<Book> books;

  const BooksState(this.books);
}

class BooksInitial extends BooksState {
  BooksInitial() : super([]);
}

class BooksDownloaded extends BooksState {
  final List<Book> newBooks;

  const BooksDownloaded(this.newBooks) : super(newBooks);
}

class BooksLoading extends BooksState {
  BooksLoading() : super([]);
}
