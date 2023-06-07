import '../model/shopping_cart_item.dart';

class ShoppingCartState {
  final List<ShoppingCartItem> items;

  const ShoppingCartState({this.items = const []});

  ShoppingCartState copyWith(ShoppingCartItem item) {
    if (!items.contains(item)) {
      return ShoppingCartState(items: [...items, item]);
    }
    return updateQty(item, 1);
  }

  ShoppingCartState copyWithout(ShoppingCartItem item) {
    return ShoppingCartState(
        items: items.where((el) => item.book.isbn != el.book.isbn).toList());
  }

  ShoppingCartState updateQty(ShoppingCartItem item, int q) {
    return ShoppingCartState(
        items: items.map((e) {
      if (e.book.isbn == item.book.isbn) {
        e.qty += q;
        e.totalPrice = e.book.price * e.qty;
      }
      return e;
    }).toList());
  }
}
