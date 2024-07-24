
import 'package:equatable/equatable.dart';

import '../../domain/entity/quotes.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object?> get props => [];
}

class QuoteLoadingState extends QuoteState {}

class QuoteLoadedState extends QuoteState {
   const QuoteLoadedState(this.quoteEntity);
   final QuoteEntity quoteEntity;

   @override
   List<Object> get props => [quoteEntity];
}

class QuoteErrorState extends QuoteState {
  const QuoteErrorState();
}
