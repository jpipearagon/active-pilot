import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImagesWidget extends StatefulWidget {
  final PageStorageKey key;
  final double height;
  final List<Widget> imagesCarousel;

  CarouselImagesWidget({this.key, this.height, this.imagesCarousel});

  @override
  _CarouselImagesWidgetState createState() => _CarouselImagesWidgetState();
}

class _CarouselImagesWidgetState extends State<CarouselImagesWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
          items: widget.imagesCarousel,
          options: CarouselOptions(
              initialPage: 0,
              disableCenter: false,
              viewportFraction: 2,
              height: widget.height-30,
              pageViewKey: widget.key,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              })),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.imagesCarousel.map((url) {
          int index = widget.imagesCarousel.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Color.fromRGBO(223,173,78,1)
                  : Color.fromRGBO(227, 227, 227, 1),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
