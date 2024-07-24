import 'package:equatable/equatable.dart';

import '../../domain/entity/quotes.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object?> get props => [];
}

class QuoteStartedEvent extends QuoteEvent {
  @override
  List<Object?> get props => [];
}


