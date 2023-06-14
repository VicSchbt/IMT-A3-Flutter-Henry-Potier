import 'dart:collection';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/api.dart';
import 'offers_state.dart';

Future<List<Offer>> getData(String isbns) async => ApiClient().getOffers(isbns);

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());

  void fetchData(List<Book> books, double total) async {
    Map<String, double> priceAfterOffers = HashMap();
    double price = 0;

    emit(OffersLoading());

    //TODO : uncomment the following line if we are able to retrieve the booklist
    String ibnsToString = books.map((book) => book.isbn).join(',');
    // String ibnsToString =
    //     "c8fabf68-8374-48fe-a7ea-a00ccd07afff,a460afed-e5e7-4e39-a39d-c885c05db861";

    List<Offer> offers = await getData(ibnsToString);

    for (var offer in offers) {
      switch (offer.type) {
        case "percentage":
          price = total - total * offer.value / 100;
          break;
        case "minus":
          price = total - offer.value;
          break;
        case "slice":
          int sliceQty = (total ~/ offer.sliceValue!);
          price = total - sliceQty * offer.value;
          break;
        default:
          break;
      }
      priceAfterOffers[offer.type] = price;
    }

    List<MapEntry<String, double>> list = priceAfterOffers.entries.toList();
    list.sort((e1, e2) => e1.value.compareTo(e2.value));

    final Map<String, double> sortedOffers = Map.fromEntries(list);

    final bestOffer = sortedOffers.entries.first;

    print("best offer determined : $sortedOffers");

    emit(OffersDownloaded(offers, bestOffer.key, bestOffer.value));
    print("offer part emit");
  }
}
