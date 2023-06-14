import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imt_a3_flutter_henry_potier/details_page.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/model/shopping_cart_item.dart';

import 'api/api.dart';
import 'cubit/books_cubit.dart';
import 'cubit/books_state.dart';
import 'shopping_cart/bloc/shopping_cart_blocs.dart';
import 'shopping_cart/bloc/shopping_cart_events.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(child: BooksPage()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                Navigator.pushNamed(
                  context,
                  '/cart',
                )
              },
          tooltip: 'Panier',
          child: const Icon(Icons.shopping_cart_outlined)),
    );
  }
}

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  void addToBasket(BuildContext context, Book book) {
    var item = ShoppingCartItem(book: book, qty: 1, totalPrice: book.price * 1);
    BlocProvider.of<ShoppingCartBloc>(context).add(AddToCartEvent(item));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(builder: (context, state) {
      if (state is BooksDownloaded) {
        final data = state.books;
        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsPage(title: data[index].title),
                        settings: RouteSettings(
                          arguments: data[index],
                        ),
                      )),
                  child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(data[index].cover,
                                      width: MediaQuery.of(context).size.width /
                                          4),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(data[index].title)),
                                        Padding(
                                            padding: const EdgeInsets.all(10),
                                            child:
                                                Text("${data[index].price}€")),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                addToBasket(
                                                    context, data[index]);
                                              },
                                              child: const Text(
                                                  "Ajouter au panier")),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))));
            });
      } else {
        if (state is BooksInitial) {
          context.read<BooksCubit>().fetchData();
        }
        return const CircularProgressIndicator();
      }
    });
  }
}
