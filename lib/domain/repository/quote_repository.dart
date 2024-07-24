import 'package:flutter_quote/domain/entity/quotes.dart';

abstract class QuoteRepository {
  Future<QuoteEntity> getQuoteList();
}
