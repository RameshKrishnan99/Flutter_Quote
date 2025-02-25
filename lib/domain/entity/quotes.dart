import 'package:flutter_quote/data/model/quotes.dart';

class QuoteEntity {
  String? sId;
  String? content;
  String? author;
  List<String>? tags;

  QuoteEntity({this.sId,
    this.content,
    this.author,
    this.tags});

  factory QuoteEntity.fromQuoteModel(QuoteModel quoteModel) {
    return QuoteEntity(
      content: quoteModel.content,
      author: quoteModel.author,);
  }
}
