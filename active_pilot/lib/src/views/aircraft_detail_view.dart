import 'package:aircraft/src/bloc/aircraft_bloc.dart';
import 'package:aircraft/src/constants/application_colors.dart';
import 'package:aircraft/src/models/Aircraft.dart';
import 'package:aircraft/src/models/AircraftDocumentDetail.dart';
import 'package:aircraft/src/models/UserDetail.dart';
import 'package:aircraft/src/views/header_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/date_util.dart';
import 'full_carousel_image_view.dart';

class AircraftDetailView extends StatefulWidget {

  static final routeName = "aircraftDetail";

  @override
  _AircraftDetailViewState createState() => _AircraftDetailViewState();
}

class _AircraftDetailViewState extends State<AircraftDetailView> {

  final _aircraftBloc = AircraftBloc();
  Aircraft? aircraft ;

  @override
  Widget build(BuildContext context) {
    return _app(context);
  }

  Widget _app(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    aircraft = arguments?["aircraft"];
    _aircraftBloc.loaddoucmentsAircraft(aircraft?.id ?? "");

    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: Column(
        children: [
          HeaderView(title: "Aircraft Details", subtitle: ""),
          Expanded(
            child: Container(
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
                            "${aircraft?.aircraftModel?.name?.toUpperCase()} ${aircraft?.aircraftMaker?.name?.toUpperCase()}",
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
                        _detailAircraft(size),
                        Divider(
                          color: Color.fromRGBO(106,107,108,1),
                        ),
                        SizedBox(height: size.height * 0.053,),
                        ButtonTheme(
                          minWidth: 154.0,
                          height: 36.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(223, 173, 78, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.transparent)
                              ),
                            ),
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
          ),
        ],
      ),
    );
  }

  Widget _listImagesWidget(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: aircraft?.photos?.length,
      itemBuilder: (context, index) {
        if(aircraft != null){
          Photo? photo = aircraft?.photos?[index] ?? null ;
          return _imageWidget(context, photo);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _detailAircraft(Size size) {
    return Container(
      alignment: Alignment.topCenter,
      height: size.height * 0.4,
        child: StreamBuilder<List<AircraftDocumentDetail>>(
          stream: _aircraftBloc.aircraftStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<AircraftDocumentDetail>? list = snapshot.data;
              return ListView.builder(
                key: Key("detail_aircraft"),
                padding: EdgeInsets.zero,
                itemCount: list?.length ?? 0,
                itemBuilder: (context, index) {
                  AircraftDocumentDetail? airDocument = list?[index];
                  return _buildDocumentItemRow(airDocument);
                },
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text(
                    "Error load documents aircraft",
                    style: GoogleFonts.openSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(4, 41, 68, 1) // semi-bold
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        )
    );
  }

  Widget _buildDocumentItemRow(AircraftDocumentDetail? document) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _checkIcon(document?.expires ?? false, document?.expired ?? false),
                Expanded(
                  child: AutoSizeText(
                      document?.name ?? "",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "Open Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w600 ,
                          color: Color.fromRGBO(0,0,0,1)// semi-bold
                      ),
                      minFontSize: 14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis
                  ),
                ),
                _checkDate(document?.expires ?? false, document?.expirationDate ?? "")
              ],
            )
          ],
        ),
      ),
      onTap: () {

      },
    );
  }

  Widget _checkIcon(bool expires, bool expired) {
    if(expires) {
      if(expired) {
        return Container(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.close, color: Colors.red,)
        );
      } else {
        return Container(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.check, color: Colors.green,)
        );
      }
    } else {
      return Container(
          padding: EdgeInsets.all(5),
          child: Icon(Icons.check, color: Colors.green,)
      );
    }
  }

  Widget _checkDate(bool expires, String date) {
    if(expires) {
      return Container(
        width: 100,
        padding: EdgeInsets.all(5),
        alignment: Alignment.centerRight,
        child: Text(
            DateUtil.getDateFormattedFromString(date, DateUtil.yyyyMMdd),
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "Open Sans",
                fontSize: 14,
                fontWeight: FontWeight.normal ,
                color: Color.fromRGBO(0,0,0,1)// semi-bold
            )
        ),
      );
    } else {
      return Container(width: 100,);
    }
  }

  Widget _imageWidget(BuildContext context, Photo? photo) {
    final size = MediaQuery.of(context).size;

    if(photo != null) {

    }
    return GestureDetector(
      child: Hero(
        tag: photo?.id ?? "",
        child: Row(
          children: [
            Image.network(
              photo?.url ?? "",
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
              keyHero: aircraft?.id ?? "",
              listImages: aircraft?.photos ?? [],
              feedId: photo?.id ?? "",
              height: 500,
            )));
      },
    );
  }
}
