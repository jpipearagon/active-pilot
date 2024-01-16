import 'package:aircraft/src/models/UserDetail.dart';
import 'package:flutter/material.dart';

import 'carousel_image_view.dart';

class FullCarouselImageView extends StatelessWidget {

  final String? keyHero;
  final List<Photo>? listImages;
  final String? feedId;
  final double? height;

  FullCarouselImageView({this.height, this.feedId, this.keyHero, this.listImages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _backGround(),
          _image(context),
          Container(
            margin: EdgeInsets.only(top: 40, left: 10),
            child: GestureDetector(
              child: Icon(Icons.close,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _backGround() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black
        )
    );
  }

  Widget _image(BuildContext context) {

    final heightTop = (MediaQuery.of(context).size.height/2) - (height ?? 0/2);

    return Container(
      margin: EdgeInsets.only(top: heightTop),
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child:  Hero(
            tag: keyHero ?? 0,
            child: CarouselImagesWidget(
              key: PageStorageKey("$feedId"),
              height: height,
              imagesCarousel: _images(listImages ?? []),
            )
        ),
      ),
    );
  }

  List<Widget> _images(List<Photo> list) {
    return list.map((resource) {
      return Image.network(
        resource.url ?? "",
        fit: BoxFit.fitHeight,
        filterQuality: FilterQuality.high,
      );
    }).toList();
  }

}