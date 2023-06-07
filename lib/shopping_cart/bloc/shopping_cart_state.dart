import '../model/shopping_cart_item.dart';

class ShoppingCartState {
  final List<ShoppingCartItem> items;

  const ShoppingCartState({this.items = const []});

  ShoppingCartState copyWith(ShoppingCartItem item) {
    return ShoppingCartState(items: [...items, item]);
  }

  ShoppingCartState copyWithout(ShoppingCartItem item) {
    // var tmp = [...items];
    // tmp.remove(item);
    return ShoppingCartState(
        items: items.where((el) => item.book.isbn != el.book.isbn).toList());
  }
}
