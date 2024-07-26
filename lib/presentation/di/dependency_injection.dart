
import 'dart:io';

import 'package:flutter_quote/data/datasource/quote_remote_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../../data/repository_impl/quote_repository_impl.dart';
import '../../domain/repository/quote_repository.dart';
import '../../domain/usecase/get_quote_usecase.dart';
import '../bloc/quote_bloc.dart';

GetIt getIt = GetIt.instance;

Future configureDependencies() async {

  getIt.registerLazySingleton<Client>(() => Client());

  //repository
  getIt.registerLazySingleton<QuoteRemoteDataSource>(() => QuoteRemoteDataSourceImpl(getIt()));

  //repository
  getIt.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(getIt()));

  //use case
  getIt.registerLazySingleton<GetQuoteUseCase>(() => GetQuoteUseCase(getIt()));

  //bloc
  getIt.registerFactory<QuoteBloc>(() => QuoteBloc(getQuoteUseCase: getIt()));


}