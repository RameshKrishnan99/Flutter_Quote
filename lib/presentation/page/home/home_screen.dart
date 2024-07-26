import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote/presentation/page/home/component/carousel.dart';

import '../../bloc/quote_bloc.dart';
import '../../bloc/quote_state.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text('Famous Quote'),
        //
        // ),
        body: BlocBuilder<QuoteBloc, QuoteState>(
          builder: (context, state) {
            if (state is QuoteLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is QuoteLoadedState) {
              return Carousel(quoteEntity: state.quoteEntity);
            }
            return const Text('Something went wrong!');
          },
        ));
  }

}

