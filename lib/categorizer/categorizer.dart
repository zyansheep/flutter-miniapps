import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class Categorizer extends StatefulWidget {
  @override
  State<Categorizer> createState() => _CategorizerState();
}

class _CategorizerState extends State<Categorizer> {
  final List<AssetImage> images = [
    "20190306_091010.jpg",
    "20190306_091045.jpg",
    "20190306_091345.jpg",
    "20190312_131718.jpg",
    "20190312_131833.jpg",
    "20190312_132107.jpg",
    "20190312_132223.jpg",
    "20190312_132430.jpg",
  ].map((e) => AssetImage("kramdr_photos/" + e)).toList();
  List<List<bool>> isSelected = List.filled(8, [false, true, false]);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: Text("Categorizer 3000")),
        body: Container(
            child: Center(
                child: CarouselSlider.builder(
                options: CarouselOptions(
            height: 500,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  autoPlay: false,
                  scrollDirection: Axis.horizontal,
                ),
          itemCount: images.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Column(children: [
            Image(image: images[itemIndex]),
                          ToggleButtons(
                            children: <Widget>[
                              Icon(Icons.check_circle_outlined),
                              Icon(Icons.adjust_outlined),
                              Icon(Icons.block),
                            ],
                            onPressed: (int index) {
                              setState(() {
                                for (int buttonIndex = 0;
                                    buttonIndex < isSelected[itemIndex].length;
                                    buttonIndex++) {
                                  if (buttonIndex == index) {
                                    isSelected[itemIndex][buttonIndex] =
                                        !isSelected[itemIndex][buttonIndex];
                                  } else {
                                    isSelected[itemIndex][buttonIndex] = false;
                                  }
                                }
                              });
                            },
                            isSelected: isSelected[itemIndex],
                          ),
          ]),
        ))));
  }
}
