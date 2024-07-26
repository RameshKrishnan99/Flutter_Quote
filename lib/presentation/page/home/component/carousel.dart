import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote/presentation/bloc/quote_bloc.dart';
import 'package:flutter_quote/presentation/widgets/gradient_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../domain/entity/quotes.dart';
import '../../../bloc/quote_event.dart';

class Carousel extends StatelessWidget {
  CarouselController buttonCarouselController = CarouselController();
  final QuoteEntity quoteEntity;
  static const platform = MethodChannel('com.rk.native_share/share');
  Carousel({super.key, required this.quoteEntity});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://picsum.photos/${size.width.toInt()}/${size.height.toInt()}'),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:  Card(
                    color: Colors.white54,
                    elevation: 0.5,child:  Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          quoteEntity.content ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(fontSize: 22 , fontWeight: FontWeight.w700),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                " - ${quoteEntity.author}" ?? "",
                                style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400),
                              ),
                            )),
                      ],
                    ))),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.white60,
                    elevation: 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    child: const Icon(
                                      Icons.refresh,
                                      color: Colors.red,
                                    ),
                                    onTap: () {
                                      context
                                          .read<QuoteBloc>()
                                          .add(QuoteStartedEvent());
                                    },
                                  ),
                                  GestureDetector(
                                    child: const Icon(
                                      Icons.share,
                                      color: Colors.blue,
                                    ),
                                    onTap: () {
                                      shareText("${quoteEntity.content}\n       - ${quoteEntity.author}");
                                    },
                                  ),

                                  /*const Icon(
                                    CupertinoIcons.heart,
                                    color: Colors.red,
                                  )*/
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> shareText(String? text) async {
    try {
      print(text);
      await platform.invokeMethod('shareText', {'text': text});
    } on PlatformException catch (e) {
      print("Failed to share text: ${e.message}");
    }
  }
}
