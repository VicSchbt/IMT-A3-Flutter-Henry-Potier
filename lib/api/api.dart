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

@JsonSerializable()
class Book {
  String isbn;
  String title;
  int price;
  String cover;
  List<String> synopsis;

  Book(
      {required this.isbn,
      required this.title,
      required this.price,
      required this.cover,
      required this.synopsis});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  get book => this;
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
