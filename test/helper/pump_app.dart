import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote/presentation/bloc/quote_bloc.dart';
import 'package:flutter_quote/presentation/bloc/quote_event.dart';
import 'package:flutter_quote/presentation/bloc/quote_state.dart';
import 'package:flutter_quote/presentation/routing/go_router.dart';
import 'package:flutter_test/flutter_test.dart';

class MockQuoteBloc extends MockBloc<QuoteEvent, QuoteState> implements QuoteBloc {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    QuoteBloc? quoteBloc,
    required Widget child,
  }) {

    return pumpWidget(MultiBlocProvider(
        providers: [
          if (quoteBloc != null)
            BlocProvider(create: (_) => quoteBloc..add(QuoteStartedEvent()))
          else
            BlocProvider(
                create: (_) =>
                MockQuoteBloc()
                  ..add(QuoteStartedEvent())),
        ],
        child: MaterialApp.router(
          title: 'Quote',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
        )));
  }
}
