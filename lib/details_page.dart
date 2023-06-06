import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.title});

  final String title;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:  const Center (
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello je suis le détail du livre"),
        ]
    )
  ),
      floatingActionButton: FloatingActionButton(
          onPressed:  () => { Navigator.pushNamed(
            context,
            '/cart',
          ) },
          tooltip: 'Panier',
          child: const Icon(Icons.shopping_cart_outlined)
      ),
    );
  }
}