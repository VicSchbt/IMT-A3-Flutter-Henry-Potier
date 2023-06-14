import 'package:flutter/material.dart';
import 'package:imt_a3_flutter_henry_potier/api/api.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.title});

  final String title;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)!.settings.arguments as Book;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          if (MediaQuery.of(context).size >= const Size(1100, 0))
            Row(children: [
              Expanded(
                flex: 33,
                child: Image.network(book.cover,
                    alignment: Alignment
                        .center), // Sometimes issues with Image.network on vscode: run with | flutter run -d chrome --web-renderer html |
              ),
              Expanded(
                  flex: 67,
                  child: Column(
                    children: [
                      const Text('Synopsis', style: TextStyle(fontSize: 20)),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          book.synopsis
                              .toString()
                              .replaceFirst('[', '')
                              .replaceFirst(']', ''),
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Text("Prix : ${book.price} €",
                            style: const TextStyle(fontSize: 20)),
                      ),
                      ElevatedButton(
                          onPressed: addToBasket,
                          child: const Text("Ajouter au panier")),
                    ],
                  )),
            ]),
          if (MediaQuery.of(context).size < const Size(1100, 10000))
            Column(children: [
              const Padding(padding: EdgeInsets.only(top: 20)),
              Image.network(book.cover,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width /
                      4), // Sometimes issues with Image.network on vscode: run with | flutter run -d chrome --web-renderer html |
              Column(
                children: [
                  const Text('Synopsis', style: TextStyle(fontSize: 20)),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      book.synopsis
                          .toString()
                          .replaceFirst('[', '')
                          .replaceFirst(']', ''),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text("Prix : ${book.price} €",
                        style: const TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                      onPressed: addToBasket,
                      child: const Text("Ajouter au panier")),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                ],
              )
            ]),
        ]),
      ),
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

  void addToBasket() {}
}
