import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_quote/presentation/bloc/quote_event.dart';
import 'package:flutter_quote/presentation/bloc/quote_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/usecase/get_quote_usecase.dart';


class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetQuoteUseCase getQuoteUseCase;

  ConnectivityResult? connectivityResult;

  QuoteBloc(
      {required this.getQuoteUseCase,
      })
      : super(QuoteLoadingState()) {
    on<QuoteStartedEvent>(_onStarted);

  }

  void _onStarted(QuoteStartedEvent event, Emitter<QuoteState> emit) async {
    emit(QuoteLoadingState());
    try {
      print("Connection result bloc $connectivityResult");
      var data = await getQuoteUseCase.execute(connectivityResult != ConnectivityResult.none);
      emit(QuoteLoadedState(data));
    } catch (e) {
      emit(const QuoteErrorState());
    }
  }
}
