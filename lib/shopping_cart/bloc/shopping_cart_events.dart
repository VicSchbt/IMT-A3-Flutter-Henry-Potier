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

class UpdateQtyEvent extends ShoppingCartEvents {
  final ShoppingCartItem item;
  final int q;

  UpdateQtyEvent(this.item, this.q);
}

class CheckoutEvent extends ShoppingCartEvents {
  CheckoutEvent();
}
