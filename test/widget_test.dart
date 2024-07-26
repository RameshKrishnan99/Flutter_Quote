import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quote/data/datasource/quote_remote_data_source.dart';
import 'package:flutter_quote/data/model/quotes.dart';
import 'package:flutter_quote/domain/entity/quotes.dart';
import 'package:flutter_quote/domain/usecase/get_quote_usecase.dart';
import 'package:flutter_quote/presentation/bloc/quote_bloc.dart';
import 'package:flutter_quote/presentation/page/home/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:mockito/annotations.dart";
import 'package:mockito/mockito.dart';

import 'di/dependency_injection.dart';
import 'helper/pump_app.dart';
import 'package:http/http.dart' as http;

import 'widget_test.mocks.dart';
// class MockClient extends Mock implements http.Client {}
@GenerateMocks([
  GetQuoteUseCase,
  http.Client
])
void main() {
  QuoteEntity mockQuote = QuoteEntity(content: 'Test quote content', author: 'Test author');
  QuoteEntity offlineMockQuote = QuoteEntity(content: 'Offline Test quote content', author: 'Offline Test author');
  late GetQuoteUseCase getGetQuoteUseCase;
  late QuoteBloc quoteBloc;
  setUp(() {
    quoteBloc = provideQuoteBloc();
    getGetQuoteUseCase = MockGetQuoteUseCase();
    when(getGetQuoteUseCase.execute(true))
        .thenAnswer((_) => Future.value(mockQuote));
    when(getGetQuoteUseCase.execute(false))
        .thenAnswer((_) => Future.value(offlineMockQuote));
  });
  setUpAll(() => HttpOverrides.global = null);
  tearDown(() => quoteBloc.close());
  QuoteBloc buildQuoteBloc() {
    return QuoteBloc(
      getQuoteUseCase: getGetQuoteUseCase,);
  }
  group('QuoteScreen', () {

    testWidgets('Carousel Widget Test', (WidgetTester tester) async {
      // Create a mock QuoteEntity for testing
      final bloc = buildQuoteBloc();
      bloc.connectivityResult =ConnectivityResult.mobile;
      // Build the widget
      await tester.pumpApp(
        quoteBloc: bloc,
        child: HomeScreen(),);
      await tester.pumpAndSettle();
      expect(find.text('Test quote content'), findsOneWidget);
      expect(find.text(' - Test author'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      bloc.connectivityResult =ConnectivityResult.none;
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pumpAndSettle();

      expect(find.text('Offline Test quote content'), findsOneWidget);

      expect(find.text(' - Offline Test author'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.share));
      await tester.pump();



    });
  });

  group('ApiService', () {
    late QuoteRemoteDataSource dataSource;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      dataSource = QuoteRemoteDataSourceImpl(mockClient);
    });

    test('fetchData returns data if the HTTP call completes successfully', () async {
      // Arrange
      final endpoint = 'https://api.quotable.io/random';
      final responseJson = jsonEncode({
        "_id": "F-wnRFzqE6yS",
        "content":
        "A life spent making mistakes is not only more honourable but more useful than a life spent in doing nothing.",
        "author": "Bernard Shaw",
        "authorId": "5TGPiANwITkM",
        "tags": ["literature", "famous-quotes", "motivational"],
        "length": 108
      });

      when(mockClient.get(Uri.parse(endpoint)))
          .thenAnswer((_) async => http.Response(responseJson, 200));

      // Act
      final result = await dataSource.getRandomQuote();

      // Assert
      expect(result, isA<QuoteModel>());
      expect(result.sId, 'F-wnRFzqE6yS');
    });

    test('fetchData throws an exception if the HTTP call completes with an error', () async {
      // Arrange
      final endpoint = 'https://api.quotable.io/random';

      when(mockClient.get(Uri.parse(endpoint)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act & Assert
      expect(() => dataSource.getRandomQuote(), throwsException);
    });
  });
}