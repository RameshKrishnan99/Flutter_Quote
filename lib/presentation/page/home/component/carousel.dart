
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {

  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Container(
                  width: size.width,
                  height: size.height,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://picsum.photos/${size.width}/${size.height}'),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "If we all did the thingsfffff fffjhjfhas dhfjkhafhkj dhakfjhdjkfh aksfhkadshfka dshfkjahdsfk jhadskfhdask hfkdashf kjdshfk ahskdhk",
                            maxLines: 3,
                            style: TextStyle(
                                fontFamily: 'AirbnbCerealBold',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.refresh,
                                  color: Colors.red,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.share,
                                  color: Colors.blue,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}