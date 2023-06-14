import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api.dart';
import 'books_state.dart';

Future<List<Book>> getData() async => RestClient(Dio()).getBooks();

class BooksCubit extends Cubit<BooksState> {
  BooksCubit() : super(BooksInitial());

  void fetchData() async {
    emit(BooksLoading());

    emit(BooksDownloaded(await getData()));
  }
}