import '../model/shopping_cart_item.dart';
import 'package:equatable/equatable.dart';

abstract class ShoppingCartState extends Equatable {
  final List<ShoppingCartItem> items;

  ShoppingCartState(this.items);
}

class ShoppingCartInitial extends ShoppingCartState {
  ShoppingCartInitial() : super([]);
}

class ShoppingCartInUse extends ShoppingCartState {
  ShoppingCartInUse() : super([]);
}
