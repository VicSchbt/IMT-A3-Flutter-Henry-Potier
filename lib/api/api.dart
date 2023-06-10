import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://henri-potier.techx.fr/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/books")
  Future<List<Book>> getBooks();
}

class ApiClient {
  Future<List<Offer>> getOffers(String isbns) async {
    List<Offer> res = [];
    Response response = await Dio().get(
        "https://henri-potier.techx.fr/books/$isbns/commercialOffers");
    final data = jsonDecode(response.toString());

    List<dynamic> list = data['offers'];
    for (var e in list) {
      if(e['sliceValue'] != null) {
        res.add(Offer(type: e['type'], value: e['value'], sliceValue: e['sliceValue']));
      } else {
        res.add(Offer(type: e['type'], value: e['value'], sliceValue: 0));
      }
    }

    print("res : $res");
    return res;
  }
}

@JsonSerializable()
class Book {
  String isbn;
  String title;
  int price;
  String cover;
  List<String> synopsis;

  Book({required this.isbn, required this.title, required this.price, required this.cover, required this.synopsis});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}


class Offer {
  String type;
  int value;
  int? sliceValue;

  Offer({required this.type, required this.value, this.sliceValue});
}