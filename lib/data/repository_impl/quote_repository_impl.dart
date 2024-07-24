import 'package:flutter_quote/data/datasource/quote_remote_data_source.dart';

import '../../domain/entity/quotes.dart';
import '../../domain/repository/quote_repository.dart';


class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;
  QuoteRepositoryImpl(this.remoteDataSource);



  @override
  Future<QuoteEntity> getQuoteList() async {
    final result = await remoteDataSource.getRandomQuote();
    return QuoteEntity.fromQuoteModel(result);
  }


}
