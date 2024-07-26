
import 'package:flutter_quote/data/datasource/quote_remote_data_source.dart';
import 'package:flutter_quote/data/repository_impl/quote_repository_impl.dart';
import 'package:flutter_quote/domain/repository/quote_repository.dart';
import 'package:flutter_quote/domain/usecase/get_quote_usecase.dart';
import 'package:flutter_quote/presentation/bloc/quote_bloc.dart';

import '../mock/mock_datasource.dart';

//datasource
QuoteRemoteDataSource provideDataSource() => MockRemoteSource();

//repository
QuoteRepository provideQuoteRepository() =>
    QuoteRepositoryImpl(provideDataSource());

//use case
GetQuoteUseCase provideGetQuoteUseCase() =>
    GetQuoteUseCase(provideQuoteRepository());

//bloc
QuoteBloc provideQuoteBloc() => QuoteBloc(
    getQuoteUseCase: provideGetQuoteUseCase(),);

