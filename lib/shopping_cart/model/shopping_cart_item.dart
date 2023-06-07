import 'package:imt_a3_flutter_henry_potier/api/api.dart';

class ShoppingCartItem {
  Book book;
  int qty;
  int totalPrice;

  ShoppingCartItem(
      {required this.book, required this.qty, required this.totalPrice});

  @override
  bool operator ==(Object other) {
    return other is Book && book.isbn == other.book.isbn;
  }

  @override
  int get hashCode {
    var tmp = "";
    for (var element in book.isbn.runes) {
      tmp += element as String;
    }
    return int.parse(tmp);
  }
}
