import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imt_a3_flutter_henry_potier/cubit/offers_state.dart';

import 'cubit/offers_cubit.dart';
import 'package:imt_a3_flutter_henry_potier/api/api.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/bloc/shopping_cart_blocs.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/bloc/shopping_cart_events.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/bloc/shopping_cart_state.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/model/shopping_cart_item.dart';

import 'shopping_cart/shopping_cart_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.title});

  final String title;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
        builder: (context, state) {
      var items = state.items;

      var totalQty = items.fold(0, (acc, cur) => acc + cur.qty);
      var totalPrice = items.fold(0, (acc, cur) => acc + cur.totalPrice);

      var totalBooks = items.map((e) => e.book).toList();

      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("Shopping Cart"),
            ),
            body: items.isEmpty
                ? const EmptyCartDisplay()
                : ListView.separated(
                    padding: const EdgeInsets.all(15),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ShoppingCartItemTile(item: items[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 15,
                    ),
                  ),
            bottomNavigationBar: totalQty > 0
                ? BottomAppBar(
                    shape: const CircularNotchedRectangle(),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              totalQty == 1
                                  ? '$totalQty article'
                                  : '$totalQty articles',
                            ),
                            Container(
                              height: 1.0,
                              width: 150.0,
                              color: Colors.grey.withOpacity(0.6),
                            ),
                            Text(
                              '$totalPrice €',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        OfferWidget(books: totalBooks, totalPrice: totalPrice)
                      ],
                    ),
                  )
                : null,
            floatingActionButton: totalQty > 0
                ? FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<ShoppingCartBloc>(context)
                          .add(CheckoutEvent());
                    },
                    child: const Icon(Icons.shopping_cart_checkout),
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endContained,
          ),
        ),
      );
    });
  }
}

class OfferWidget extends StatefulWidget {
  final int totalPrice;
  final List<Book> books;

  const OfferWidget({super.key, required this.totalPrice, required this.books});

  State<OfferWidget> createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersCubit, OffersState>(builder: (context, state) {
      if (state is OffersDownloaded) {
        return Column(
          children: [
            Text('Promotion : ${state.bestType}'),
            Text('Total : ${state.bestPrice} €')
          ],
        );
      } else {
        if (state is OffersInitial) {
          context
              .read<OffersCubit>()
              .fetchData(widget.books, widget.totalPrice.toDouble());
        }
        return const CircularProgressIndicator();
      }
    });
  }
}
