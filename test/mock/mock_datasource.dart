import 'package:flutter_quote/data/datasource/quote_remote_data_source.dart';
import 'package:flutter_quote/data/model/quotes.dart';

class MockRemoteSource extends QuoteRemoteDataSource {
  var quoteModel = QuoteModel(content: "Test Quote content",author: "Test Author ",);
  var offlineQuoteModel = QuoteModel(content: "Offline Test Quote content",author: "Offline Test Author ",);


  @override
  QuoteModel getOfflineRandomQuote() {
    return offlineQuoteModel;
  }

  @override
  Future<QuoteModel> getRandomQuote() {
    return Future.value(quoteModel);
  }

}