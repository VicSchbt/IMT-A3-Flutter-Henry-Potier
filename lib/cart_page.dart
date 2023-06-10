import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imt_a3_flutter_henry_potier/cubit/offers_state.dart';

import 'cubit/offers_cubit.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.title});

  final String title;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello, voici la liste de livres dans ton panier."),
              OfferWidget(),
            ],
          )
      ),
    );
  }
}

class OfferWidget extends StatefulWidget {
  const OfferWidget({super.key});

  State<OfferWidget> createState() => _OfferWidgetState();

}

class _OfferWidgetState extends State<OfferWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersCubit,OffersState>(builder: (context, state) {
        if (state is OffersDownloaded) {
          return Column(
            children: [
              Text('Promotion : ${state.bestType}'),
              Text('Total : ${state.bestPrice} €')
            ],
          );
        } else {
          if (state is OffersInitial) {
            context.read<OffersCubit>().fetchData([],50);
          }
           return const CircularProgressIndicator();
        }
    });
  }

}