import 'package:aircraft/src/models/Aircraft.dart';
import 'package:aircraft/src/models/UserDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'full_carousel_image_view.dart';

class AircraftDetailView extends StatefulWidget {

  static final routeName = "aircraftDetail";

  @override
  _AircraftDetailViewState createState() => _AircraftDetailViewState();
}

class _AircraftDetailViewState extends State<AircraftDetailView> {

  Aircraft aircraft ;

  @override
  Widget build(BuildContext context) {
    return _app(context);
  }

  Widget _app(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final Map arguments = ModalRoute.of(context).settings.arguments;
    aircraft = arguments["aircraft"];

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        title:  Transform(
          // you can forcefully translate values left side using Transform
          transform:  Matrix4.translationValues(14.0, 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Details",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 30,
                      fontWeight: FontWeight.w600 ,
                      color: Colors.white// semi-bold
                  )
              )
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(4, 41, 68, 1),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 10),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromRGBO(4, 41, 68, 1)
          ),
          child: Container(
            padding: EdgeInsets.only(top: 42, left: 36, right: 36),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                )
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height* 0.04,),
                  Text(
                      "${aircraft.aircraftModel.name.toUpperCase()} ${aircraft.aircraftMaker.name.toUpperCase()}",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 20,
                          fontWeight: FontWeight.w700 ,
                          color: Color.fromRGBO(4,41,68,1)// semi-bold
                      )
                  ),
                  Container(
                    width: double.infinity,
                      height: size.width * 0.155,
                      margin: EdgeInsets.symmetric(horizontal: 26, vertical: size.height* 0.045),
                      child: _listImagesWidget(context)
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.1718),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Annual",
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600 ,
                                    color: Color.fromRGBO(0,0,0,1)// semi-bold
                                )
                            ),
                            Text(
                                "04/12/2020",
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400 ,
                                    color: Color.fromRGBO(106,107,108,1)// semi-bold
                                )
                            )
                          ],
                        ),
                        SizedBox(height: size.height * 0.053,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Vor check",
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600 ,
                                    color: Color.fromRGBO(0,0,0,1)// semi-bold
                                )
                            ),
                            Text(
                                "04/12/2020",
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400 ,
                                    color: Color.fromRGBO(106,107,108,1)// semi-bold
                                )
                            )
                          ],
                        ),
                        SizedBox(height: size.height * 0.053,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "100 Hour",
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600 ,
                                    color: Color.fromRGBO(0,0,0,1)// semi-bold
                                )
                            ),
                            Text(
                                "04/12/2020",
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400 ,
                                    color: Color.fromRGBO(106,107,108,1)// semi-bold
                                )
                            )
                          ],
                        ),
                        SizedBox(height: size.height * 0.053,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "ADS",
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600 ,
                                    color: Color.fromRGBO(0,0,0,1)// semi-bold
                                )
                            ),
                            Text(
                                "04/12/2020",
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400 ,
                                    color: Color.fromRGBO(106,107,108,1)// semi-bold
                                )
                            )
                          ],
                        ),
                        SizedBox(height: size.height * 0.053,),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(106,107,108,1),
                  ),
                  SizedBox(height: size.height * 0.053,),
                  ButtonTheme(
                    minWidth: 154.0,
                    height: 36.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)
                      ),
                      color: Color.fromRGBO(223, 173, 78, 1),
                      child: Text(
                        "Accept",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )

                ],
              ),
            ),
          )
      ),
    );
  }

  Widget _listImagesWidget(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: aircraft.photos.length,
      itemBuilder: (context,index) {
        return _imageWidget(context, aircraft.photos[index]);
      },
    );
  }

  Widget _imageWidget(BuildContext context, Photo photo) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      child: Hero(
        tag: photo.id,
        child: Row(
          children: [
            Image.network(
              photo.url,
              height: size.width * 0.155,
              width: size.height * 0.13125,
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
            ),
            SizedBox(width: 8,)
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => FullCarouselImageView(
              keyHero: aircraft.id,
              listImages: aircraft.photos,
              feedId: photo.id,
              height: 500,
            )));
      },
    );
  }

}
