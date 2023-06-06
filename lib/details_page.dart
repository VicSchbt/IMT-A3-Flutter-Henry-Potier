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
      body:  Center (
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Hello je suis le détail du livre"),
          ElevatedButton(
              child: const Text("Panier"),
              onPressed: () => { Navigator.pushNamed(
                  context,
                  '/cart',
              ) },
          )
        ]
    )
  ),
    );
  }
}