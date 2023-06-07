import 'package:imt_a3_flutter_henry_potier/api/api.dart';
import 'package:equatable/equatable.dart';

class ShoppingCartItem extends Equatable {
  Book book;
  int qty;
  int totalPrice;

  ShoppingCartItem(
      {required this.book, required this.qty, required this.totalPrice});

  @override
  List<Object?> get props => [book.isbn];
}
