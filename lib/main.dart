import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote/presentation/bloc/quote_bloc.dart';
import 'package:flutter_quote/presentation/bloc/quote_event.dart';

import 'presentation/di/dependency_injection.dart';
import 'presentation/routing/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final QuoteBloc quoteBloc = getIt<QuoteBloc>();

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => quoteBloc..add(QuoteStartedEvent()),
          ),
        ],
        child: MaterialApp.router(
          title: 'Famous Quotes',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
        ));
  }
}

