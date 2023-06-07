import 'package:imt_a3_flutter_henry_potier/shopping_cart/model/shopping_cart_item.dart';

abstract class ShoppingCartEvents {
  ShoppingCartEvents();
}

class AddToCartEvent extends ShoppingCartEvents {
  final ShoppingCartItem itemToAdd;

  AddToCartEvent(this.itemToAdd);
}

class RemoveFromCartEvent extends ShoppingCartEvents {
  final ShoppingCartItem itemToRemove;

  RemoveFromCartEvent(this.itemToRemove);
}

class CheckoutEvent extends ShoppingCartEvents {
  CheckoutEvent();
}
