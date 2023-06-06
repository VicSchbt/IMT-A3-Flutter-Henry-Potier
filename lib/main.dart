import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imt_a3_flutter_henry_potier/home_page.dart';
import 'package:imt_a3_flutter_henry_potier/details_page.dart';
import 'package:imt_a3_flutter_henry_potier/cart_page.dart';

import 'cubic/books_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BooksCubit(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: {
              '/': (context) => const MyHomePage(title: 'Henri Pottier Library'),
              '/details': (context) => const DetailsPage(title: 'Details',),
              '/cart': (context) => const CartPage(title: "Panier"),
            })
    );
  }
}
