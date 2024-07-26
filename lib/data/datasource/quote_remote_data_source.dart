import 'dart:convert';
import 'dart:math';

import 'package:flutter_quote/data/model/quotes.dart';

import 'package:http/http.dart' as http;

import 'offline_quotes.dart';

abstract class QuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();

  QuoteModel getOfflineRandomQuote();
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
    late http.Client client;
    QuoteRemoteDataSourceImpl(this.client);
  @override
  Future<QuoteModel> getRandomQuote() async {
    // final response =
    // await client.get(Uri.parse('https://api.quotable.io/random'));
    final response = await client.get(
      Uri.parse('https://api.quotable.io/random'),
    );
    if (response.statusCode == 200) {
      return QuoteModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load quotes');
    }
  }

  @override
  QuoteModel getOfflineRandomQuote() {
    return getRandom();
  }

  static QuoteModel getRandom() {
    return QuoteModel.fromJson(allquotes[_getRandomIndex()]);
  }

  static int _getRandomIndex() {
    return Random.secure().nextInt(allquotes.length);
  }
}
