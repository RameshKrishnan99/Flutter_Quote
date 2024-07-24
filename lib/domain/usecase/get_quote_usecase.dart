
import '../entity/quotes.dart';
import '../repository/quote_repository.dart';

class GetQuoteUseCase {
  final QuoteRepository repository;
  GetQuoteUseCase(this.repository);

  Future<QuoteEntity> execute() async {
    return await repository.getQuoteList();
  }
}
