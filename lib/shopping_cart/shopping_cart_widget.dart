import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/bloc/shopping_cart_blocs.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/bloc/shopping_cart_events.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/model/shopping_cart_item.dart';

class ShoppingCartItemTile extends StatelessWidget {
  const ShoppingCartItemTile({
    super.key,
    required this.item,
  });

  final ShoppingCartItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 150,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(item.book.cover),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.book.title,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'p.u. : ${item.book.price} €',
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (item.qty > 1) {
                                BlocProvider.of<ShoppingCartBloc>(context)
                                    .add(UpdateQtyEvent(item, -1));
                              }
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text('${item.qty}'),
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<ShoppingCartBloc>(context)
                                  .add(UpdateQtyEvent(item, 1));
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      Text(
                        '${item.totalPrice} €',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                BlocProvider.of<ShoppingCartBloc>(context)
                    .add(RemoveFromCartEvent(item));
              },
              icon: const Icon(Icons.delete_outlined),
            )
          ],
        ),
      ),
    );
  }
}

class EmptyCartDisplay extends StatelessWidget {
  const EmptyCartDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.add_shopping_cart,
            color: Colors.grey.withOpacity(0.75),
            size: 64,
          ),
          Text(
            "Votre panier est vide.",
            style:
                TextStyle(color: Colors.grey.withOpacity(0.75), fontSize: 32.0),
          ),
        ],
      ),
    );
  }
}
