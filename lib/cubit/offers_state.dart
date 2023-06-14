import '../api/api.dart';

abstract class OffersState {
  final List<Offer> offers;
  final String bestType;
  final double bestPrice;

  const OffersState(this.offers, this.bestType,this.bestPrice);
}

class OffersInitial extends OffersState {
  OffersInitial() : super([], "", 0);
}

class OffersDownloaded extends OffersState {
  final List<Offer> newOffers;
  final String type;
  final double price;

  const OffersDownloaded(this.newOffers, this.type,this.price) : super(newOffers, type, price);
}

class OffersLoading extends OffersState {
  OffersLoading() :  super([], "", 0);
}