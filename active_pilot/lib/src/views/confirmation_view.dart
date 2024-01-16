import 'dart:io';

import 'package:aircraft/src/apis/reservation_api.dart';
import 'package:aircraft/src/constants/application_colors.dart';
import 'package:aircraft/src/models/CodeError.dart';
import 'package:aircraft/src/models/Reservation.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:aircraft/src/views/header_view.dart';
import 'package:aircraft/src/views/schedule_view.dart';
import 'package:aircraft/src/views/web_view.dart';
import 'package:aircraft/src/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

class ConfirmationView extends StatefulWidget {

  static final routeName = "confirmation";

  final Map? reservationData;

  ConfirmationView({this.reservationData});

  @override
  _ConfirmationViewState createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView> {

  bool _checkOne = false;
  bool _checkTwo = false;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _activityId;
  String? _instructorId;
  String? _aircraftId;
  String? _locationId;
  bool? _isLoading = false;

  @override
  void initState() {
    super.initState();
    final arguments = widget.reservationData;
    _startDate = arguments?["startDate"];
    _endDate = arguments?["endDate"];
    _activityId = arguments?["activityId"];
    _instructorId = arguments?["instructorId"];
    _aircraftId = arguments?["aircraftId"];
    _locationId = arguments?["locationId"];
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        color: Colors.white,
        opacity: 1.0,
        progressIndicator: Lottie.asset(
            'assets/gifs/35718-loader.json',
            width: 100,
            height: 100
        ),
        isLoading: _isLoading ?? false,
        child: _app(context)
    );
  }

  Widget _app(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: Column(
        children: [
          HeaderView(title: "Confirmation", subtitle: "Select the terms and conditions to continue"),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(top: 10),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(4, 41, 68, 1)
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 42, left: 46, right: 46),
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
                        Text(
                            "Example title",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                fontWeight: FontWeight.w700 ,
                                color: Color.fromRGBO(4,41,68,1)// semi-bold
                            )
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Volutpat amet, nunc, non faucibus leo ultricies amet, gravida consequat. Sed sem lobortis orci, pretium volutpat. Felis feugiat vitae risus diam magna ac massa. Ultrices nulla neque lobortis cras non nisi, nisi. Pharetra, varius sit cursus vel pharetra mollis amet pretium egestas. Ornare a odio arcu at. Sit condimentum vitae eu rutrum vivamus dui at justo. Lectus mi, ut elementum, scelerisque ultrices arcu elementum ultricies.",
                            style: TextStyle(
                                fontFamily: "Open Sans",
                                fontSize: 12,
                                fontWeight: FontWeight.w400 ,
                                color: Color.fromRGBO(0,0,0,1)// semi-bold
                            )
                        ),
                        SizedBox(
                          height: 42,
                        ),
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Color.fromRGBO(223,173,78,1)),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              "Company policy - Acknowledgment",
                              style: TextStyle(
                                  color: Color.fromRGBO(0,0,0,1),
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w600),),
                            value: _checkOne,
                            activeColor: Color.fromRGBO(4,41,68,1),
                            checkColor: Color.fromRGBO(223,173,78,1),
                            secondary: InkWell(
                                child: Icon(Icons.link, color: Colors.black,),
                              onTap: () => openFileCompany(),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _checkOne = value ?? false;
                              });
                            },
                          ),
                        ),
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Color.fromRGBO(223,173,78,1)),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              "FAA 91-103 - Acknowledgment",
                              style: TextStyle(
                                  color: Color.fromRGBO(0,0,0,1),
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w600),),
                            value: _checkTwo,
                            activeColor: Color.fromRGBO(4,41,68,1),
                            checkColor: Color.fromRGBO(223,173,78,1),
                            secondary: InkWell(
                              child: Icon(Icons.link, color: Colors.black,),
                              onTap: () => openFileFAA(),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _checkTwo = value ?? false;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: ButtonTheme(
                            minWidth: size.width * 0.48,
                            height: size.height * 0.064,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (_checkOne && _checkTwo) ? Color.fromRGBO(223, 173, 78, 1) : Color.fromRGBO(106,107,108,0.4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.5),
                                    side: BorderSide(color: Colors.transparent)
                                ),
                              ),
                              child: Text(
                                "Accept",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "Open Sans",
                                    fontWeight: FontWeight.w400),
                              ),
                              onPressed: (_checkOne && _checkTwo)? () => createReservation(context): null,
                            ),
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

  void createReservation(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final prefs = SharedPreferencesUser();
    final _reservationApi = ReservationApi();
    DateTime dateStart = _startDate?.toUtc() ?? DateTime.now();
    DateTime dateEnd = _endDate?.toUtc() ?? DateTime.now();
    final reservation =
    await _reservationApi.createReservation(dateStart.toIso8601String(), dateEnd.toIso8601String(), _activityId ?? "", _aircraftId ?? "", _instructorId ?? "", prefs.userId, _locationId ?? "");

    if(reservation != null) {

      if(reservation is Reservation) {
        setState(() {
          _isLoading = false;
          Navigator.of(context).pop(_startDate);
        });
      } else if (reservation is String) {
        final String codeError = reservation;
        setState(() {
          _isLoading = false;
          showMessage(context, "Error create reservation", codeError);
        });
      }
    } else {
      setState(() {
        _isLoading = false;
        showMessage(context, "Error create reservation", "an error occurred in the creation of the reservation ");
      });
    }
  }

  void openFileCompany() {
    if (Platform.isIOS) {
      Navigator.of(context).pushNamed(OpenWebView.routeName, arguments: {"url": "https://s3.amazonaws.com/assets.activepilot/public/companyPolicyAcknowledgement.pdf"});
    } else {
      Navigator.of(context).pushNamed(OpenWebView.routeName, arguments: {"url": "https://docs.google.com/gview?embedded=true&url=https://s3.amazonaws.com/assets.activepilot/public/companyPolicyAcknowledgement.pdf"});
    }
  }

  void openFileFAA() {
    if (Platform.isIOS) {
      Navigator.of(context).pushNamed(OpenWebView.routeName, arguments: {"url": "https://s3.amazonaws.com/assets.activepilot/public/FFA91103Acknowledgement.pdf"});
    } else {
      Navigator.of(context).pushNamed(OpenWebView.routeName, arguments: {"url": "https://docs.google.com/gview?embedded=true&url=https://s3.amazonaws.com/assets.activepilot/public/FFA91103Acknowledgement.pdf"});
    }
  }

}
