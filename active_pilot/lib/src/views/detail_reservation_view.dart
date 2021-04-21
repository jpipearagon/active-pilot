import 'package:aircraft/src/apis/reservation_api.dart';
import 'package:aircraft/src/constants/application_colors.dart';
import 'package:aircraft/src/models/Reservation.dart';
import 'package:aircraft/src/models/ReservationStatus.dart';
import 'package:aircraft/src/models/UserRole.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:aircraft/src/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

import 'header_view.dart';

class DetailReservationView extends StatefulWidget {

  static final routeName = "detail_reservation";

  @override
  _DetailReservationViewState createState() => _DetailReservationViewState();
}

class _DetailReservationViewState extends State<DetailReservationView> {

  var formatter = DateFormat("yyyy/MM/dd HH:mm a");
  bool _isLoading = false;

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
        isLoading: _isLoading,
        child: _app(context)
    );
  }

  Widget _app(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final Map arguments = ModalRoute.of(context).settings.arguments;
    final Reservation reservation = arguments["reservation"];
    DateTime startDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse("${reservation.start}");
    DateTime endDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse("${reservation.end}");

    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: Column(
        children: [
          HeaderView(title: "Detail Reservation", subtitle: "Check the reservation details"),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(top: 10),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(4, 41, 68, 1)
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 40.0,
                    left: 30.0,
                    right: 30.0
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                      )),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Status Reservation: ",
                              style: TextStyle(
                                  color: Color.fromRGBO(4, 41, 68, 1),
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${reservation.status.name}",
                              style: TextStyle(
                                  color: Color.fromRGBO(106, 107, 108, 1),
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Start Date: ",
                              style: TextStyle(
                                  color: Color.fromRGBO(4, 41, 68, 1),
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${formatter.format(startDate)}",
                              style: TextStyle(
                                  color: Color.fromRGBO(106, 107, 108, 1),
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "End Date: ",
                              style: TextStyle(
                                  color: Color.fromRGBO(4, 41, 68, 1),
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${formatter.format(endDate)}",
                              style: TextStyle(
                                  color: Color.fromRGBO(106, 107, 108, 1),
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Pilot Name: ",
                              style: TextStyle(
                                  color: Color.fromRGBO(4, 41, 68, 1),
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${reservation.pilot.firstName} ${reservation.pilot.lastName}",
                              style: TextStyle(
                                  color: Color.fromRGBO(106, 107, 108, 1),
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Aircraft Name: ",
                              style: TextStyle(
                                  color: Color.fromRGBO(4, 41, 68, 1),
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${reservation.aircraft.name}",
                              style: TextStyle(
                                  color: Color.fromRGBO(106, 107, 108, 1),
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
            ),
          ),
          _createButtons(reservation)
        ],
      ),
    );
  }

  Widget _createButtons(Reservation reservation) {
    bool showFirstButton;
    bool showSecondButton;
    String textFirstButton = "";
    String textSecondButton = "";
    ReservationStatus statusFirstButton;
    ReservationStatus statusSecondButton;

    final ReservationStatus reservationStatus = enumFromString(ReservationStatus.values, reservation.status.name.toLowerCase());

    final prefs = SharedPreferencesUser();
    final Role role = enumFromString(Role.values, prefs.role);
    switch (role) {
      case Role.instructor:
        if (reservationStatus == ReservationStatus.pending) {
          showFirstButton = true;
          showSecondButton = true;
          textFirstButton = "Accept";
          textSecondButton = "Rejected";
          statusFirstButton = ReservationStatus.approved;
          statusFirstButton = ReservationStatus.rejected;
        }
        break;

      case Role.pilot:
        if (reservationStatus == ReservationStatus.pending || reservationStatus == ReservationStatus.approved) {
          showFirstButton = true;
          showSecondButton = false;
          textFirstButton = "Cancelled";
          statusFirstButton = ReservationStatus.canceled;
        }
        break;

      case Role.student:
      case Role.registered:
        if (reservationStatus == ReservationStatus.pending || reservationStatus == ReservationStatus.approved) {
          showFirstButton = true;
          showSecondButton = false;
          textFirstButton = "Cancelled";
          statusFirstButton = ReservationStatus.canceled;
        }
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child: Column(
        children: [
          Visibility(
            child: ButtonTheme(
              minWidth: double.infinity,
              height: 45.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.transparent)
                ),
                color: Color.fromRGBO(223, 173, 78, 1),
                child: Text(
                  textFirstButton,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),
                ),
                onPressed: () => _changeStatus(reservation.sId, statusFirstButton),
              ),
            ),
            visible: showFirstButton,
          ),
          SizedBox(height: 20,),
          Visibility(
            child: ButtonTheme(
              minWidth: double.infinity,
              height: 45.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.transparent)
                ),
                color: Color.fromRGBO(223, 173, 78, 1),
                child: Text(
                  textSecondButton,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),
                ),
                onPressed: () => _changeStatus(reservation.sId, statusSecondButton),
              ),
            ),
            visible: showSecondButton,
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  void _changeStatus(String reservationId, ReservationStatus reservationStatus) async {
    setState(() {
      _isLoading = true;
    });

    final _reservationApi = ReservationApi();
    final reservation =
        await _reservationApi.changeStatusReservation(reservationId, reservationStatus);

    setState(() {
      _isLoading = false;
    });
    if(reservation != null) {
      if(reservation is Reservation) {
        Navigator.of(context).pop(true);
      } else if(reservation is String) {
        final String codeError = reservation;
        showMessage(context, "Error change reservation", codeError);
      }
    } else {
      showMessage(context, "Error Reservation", "Error change reservation.");
    }
  }
}
