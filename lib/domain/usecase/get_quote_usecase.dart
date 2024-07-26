
import '../entity/quotes.dart';
import '../repository/quote_repository.dart';

class GetQuoteUseCase {
  final QuoteRepository repository;
  GetQuoteUseCase(this.repository);

  Future<QuoteEntity> execute(bool isOnline) async {
    return await repository.getQuoteList(isOnline);
  }
}
