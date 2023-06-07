import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imt_a3_flutter_henry_potier/api/api.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/bloc/shopping_cart_blocs.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/bloc/shopping_cart_events.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/bloc/shopping_cart_state.dart';
import 'package:imt_a3_flutter_henry_potier/shopping_cart/model/shopping_cart_item.dart';

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
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              // TODO: to delete after assemble
              actions: [
                IconButton(
                    onPressed: () {
                      var book1 = Book(
                          isbn: "c8fabf68-8374-48fe-a7ea-a00ccd07afff",
                          title: "Henri Potier à l'école des sorciers",
                          price: 35,
                          cover:
                              "https://firebasestorage.googleapis.com/v0/b/henri-potier.appspot.com/o/hp0.jpg?alt=media",
                          synopsis: [
                            "Après la mort de ses parents (Lily et James Potier), Henri est recueilli par sa tante Pétunia (la sœur de Lily) et son oncle Vernon à l'âge d'un an. Ces derniers, animés depuis toujours d'une haine féroce envers les parents du garçon qu'ils qualifient de gens « bizarres », voire de « monstres », traitent froidement leur neveu et demeurent indifférents aux humiliations que leur fils Dudley lui fait subir. Henri ignore tout de l'histoire de ses parents, si ce n'est qu'ils ont été tués dans un accident de voiture",
                            "Le jour des 11 ans de Henri, un demi-géant du nom de Rubeus Hagrid vient le chercher pour l’emmener à Poudlard, une école de sorcellerie, où il est inscrit depuis sa naissance et attendu pour la prochaine rentrée. Hagrid lui révèle alors qu’il a toujours été un sorcier, tout comme l'étaient ses parents, tués en réalité par le plus puissant mage noir du monde de la sorcellerie, Voldemort (surnommé « Celui-Dont-On-Ne-Doit-Pas-Prononcer-Le-Nom »), après qu'ils ont refusé de se joindre à lui. Ce serait Henri lui-même, alors qu'il n'était encore qu'un bébé, qui aurait fait ricocher le sortilège que Voldemort lui destinait, neutralisant ses pouvoirs et le réduisant à l'état de créature quasi-insignifiante. Le fait d'avoir vécu son enfance chez son oncle et sa tante dépourvus de pouvoirs magiques lui a donc permis de grandir à l'abri de la notoriété qu'il a dans le monde des sorciers.",
                            "Henri entre donc à l’école de Poudlard, dirigée par le professeur Albus Dumbledore. Il est envoyé dans la maison Gryffondor par le « choixpeau ». Il y fait la connaissance de Ron Weasley et Hermione Granger, qui deviendront ses complices. Par ailleurs, Henri intègre rapidement l'équipe de Quidditch de sa maison, un sport collectif très populaire chez les sorciers se pratiquant sur des balais volants. Henri connaît probablement la plus heureuse année de sa vie, mais également la plus périlleuse, car Voldemort n'a pas totalement disparu et semble bien décidé à reprendre forme humaine."
                          ]);

                      var item1 = ShoppingCartItem(
                          book: book1, qty: 1, totalPrice: book1.price * 1);

                      BlocProvider.of<ShoppingCartBloc>(context)
                          .add(AddToCartEvent(item1));
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            body: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(items[index].book.cover),
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
                                items[index].book.title,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'p.u. : ${items[index].book.price} €',
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text('${items[index].qty}'),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                  Text('${items[index].totalPrice} €')
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
                                .add(RemoveFromCartEvent(items[index]));
                          },
                          icon: const Icon(Icons.delete_outlined),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),
      );
    });
  }
}
