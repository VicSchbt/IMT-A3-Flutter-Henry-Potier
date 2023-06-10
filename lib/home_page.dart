import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/books_cubit.dart';
import 'cubit/books_state.dart';

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

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(builder: (context, state) {
      if (state is BooksDownloaded) {
        final data = state.books;
        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              print("synopsis : ${data[index].synopsis.toString()}");
              return ListTile(
                title: Text(data[index].title),
                onTap: () => Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: "Hello !"
              ),
              );
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
