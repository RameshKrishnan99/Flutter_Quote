import 'dart:convert';

import 'package:flutter_quote/data/model/quotes.dart';

import 'package:http/http.dart' as http;

abstract class QuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
 
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {


  QuoteRemoteDataSourceImpl();

  @override
  Future<QuoteModel> getRandomQuote() async {
    // final response =
    // await client.get(Uri.parse('https://api.quotable.io/random'));
    final response = await http.get(
      Uri.parse('http://api.quotable.io/random'),
    );
    if (response.statusCode == 200) {
      return QuoteModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load quotes');
    }
  }

}