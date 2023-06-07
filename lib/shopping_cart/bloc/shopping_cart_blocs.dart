import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/bloc/shopping_cart_events.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/bloc/shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvents, ShoppingCartState> {
  ShoppingCartBloc() : super(const ShoppingCartState()) {
    on<AddToCartEvent>(_addToCartEvent);

    on<RemoveFromCartEvent>(_removeFromCartEvent);

    on<CheckoutEvent>(_checkoutEvent);
  }

  void _addToCartEvent(AddToCartEvent event, Emitter<ShoppingCartState> emit) {
    emit(state.copyWith(event.itemToAdd));
  }

  void _removeFromCartEvent(
      RemoveFromCartEvent event, Emitter<ShoppingCartState> emit) {
    emit(state.copyWithout(event.itemToRemove));
  }

  void _checkoutEvent(CheckoutEvent event, Emitter<ShoppingCartState> emit) {
    print("Checkout time !!!");
  }
}
