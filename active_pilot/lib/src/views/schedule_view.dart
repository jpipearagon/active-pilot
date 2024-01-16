import 'dart:io';

import 'package:aircraft/src/Constants/application_colors.dart';
import 'package:aircraft/src/apis/payment_api.dart';
import 'package:aircraft/src/bloc/schedule_bloc.dart';
import 'package:aircraft/src/models/Pay.dart';
import 'package:aircraft/src/models/Reservation.dart';
import 'package:aircraft/src/models/ReservationStatus.dart';
import 'package:aircraft/src/models/UserRole.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:aircraft/src/views/header_view.dart';
import 'package:aircraft/src/views/reservation_view.dart';
import 'package:aircraft/src/widgets/message_widget.dart';
import 'package:aircraft/utils/colors_util.dart';
import 'package:aircraft/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';

import 'check_flight_view.dart';
import 'detail_reservation_view.dart';
import 'ground_instruction_view.dart';
import 'logbook_edit_view.dart';
import 'noke_view.dart';
import 'web_view.dart';

class ScheduleView extends StatefulWidget {
  static final routeName = "schedule";

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final _scheduleBloc = ScheduleBloc();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scheduleBloc.loadSchedule(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        color: Colors.white,
        opacity: 1.0,
        progressIndicator: Lottie.asset('assets/gifs/35718-loader.json',
            width: 100, height: 100),
        isLoading: _isLoading,
        child: _app(context));
  }

  Widget _app(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: Column(
        children: [
          HeaderView(title: "Schedule", subtitle: "Choose a date to start\nNEW RESERVATION then +"),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: 14.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    )),
                child: Column(
                  children: [
                    TableCalendar(
                      focusedDay: _focusedDay,
                      firstDay: DateTime.utc(2000, 01, 01),
                      lastDay: DateTime.utc(2100, 01, 01),
                      locale: 'en_US',
                      headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleTextStyle: TextStyle(
                              color: Color.fromRGBO(46, 56, 77, 1),
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700)),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      calendarStyle: CalendarStyle(
                        selectedDecoration: const BoxDecoration(
                          color: const Color.fromRGBO(255, 204, 0, 0.13),
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(
                            color: Color.fromRGBO(32, 25, 25, 1),
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        todayDecoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: TextStyle(
                            color: Color.fromRGBO(32, 25, 25, 1),
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        weekendTextStyle: TextStyle(
                            color: Color.fromRGBO(32, 25, 25, 1),
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        outsideTextStyle:
                            TextStyle(color: const Color(0xFF9E9E9E)),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                            color: Color.fromRGBO(186, 186, 186, 1),
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        weekendStyle: TextStyle(
                            color: Color.fromRGBO(186, 186, 186, 1),
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500),
                      ),
                      onDaySelected: _onDaySelected,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(238, 238, 238, 1)),
                        child: StreamBuilder<List<Reservation>>(
                          stream: _scheduleBloc.scheduleStream,
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, index) {
                                      Reservation? reservation =
                                          snapshot.data?[index];
                                      if(reservation != null){
                                        return buildEvent(context, reservation);
                                      }
                                    },
                                  )
                                : Container();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createReservation(context),
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(223, 173, 78, 1),
      ),
    );
  }

  Widget buildEvent(BuildContext context, Reservation reservation) {

    final prefs = SharedPreferencesUser();
    var title = "";
    var subtitle = "";
    final Role role = enumFromString(Role.values, prefs.role);
    switch (role) {
      case Role.admin:
      case Role.instructor:
        title = "${reservation.userPilot?.firstName} ${reservation.userPilot?.lastName}";
        subtitle = "${reservation.activity?.name}";
        break;

      case Role.pilot:
        if (prefs.isPilot) {
          title = prefs.flyAlone ? "${reservation.aircraft?.name}" : "${reservation.userInstructor?.instructor?.scheduleName}";
          subtitle = "${reservation.activity?.name}";
        }
        break;

      case Role.student:
      case Role.registered:
        title = "${reservation.userInstructor?.instructor?.scheduleName}";
        subtitle = "${reservation.activity?.name}";
        break;
    }

    return InkWell(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        DateUtil.getDateFormattedFromString(reservation.start ?? "", DateUtil.MMMddyyyy),
                        style: GoogleFonts.montserrat(
                          //fontFamily: "Montserrat",
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(165, 164, 164, 1) // semi-bold
                        ),
                      ),
                      Text(
                        DateUtil.getDateFormattedFromString(reservation.start ?? "", DateUtil.HHmma),
                        style: GoogleFonts.montserrat(
                            //fontFamily: "Montserrat",
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(165, 164, 164, 1) // semi-bold
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        DateUtil.getDateFormattedFromString(reservation.end ?? "", DateUtil.MMMddyyyy),
                        style: GoogleFonts.montserrat(
                          //fontFamily: "Montserrat",
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(165, 164, 164, 1) // semi-bold
                        ),
                      ),
                      Text(
                        DateUtil.getDateFormattedFromString(reservation.end ?? "", DateUtil.HHmma),
                        style: GoogleFonts.montserrat(
                            //fontFamily: "Montserrat",
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(165, 164, 164, 1) // semi-bold
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Container(
                    width: 1,
                    height: MediaQuery.of(context).size.height * 0.090,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(106, 107, 108, 1)),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.montserrat(
                                //fontFamily: "Montserrat",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(4, 41, 68, 1) // semi-bold
                                ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.openSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(4, 41, 68, 1) // semi-bold
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorsUtils.getColorFromHex(
                                  reservation.status?.color ?? ""),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              10.0,
                              1.0,
                              10.0,
                              1.0,
                            ),
                            child: Text(
                              reservation.status?.name ?? "",
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white // semi-bold
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 0.3,
              width: double.infinity,
              decoration: BoxDecoration(color: Color.fromRGBO(106, 107, 108, 1)),
            ),
          ],
        ),
      ),
      onTap: () => goToReservation(context, reservation),
    );
  }

  void goToReservation(BuildContext context, Reservation reservation) {
    String sId = reservation.status?.sId ?? "";
    final ReservationStatus reservationStatus = enumFromString(ReservationStatus.values, sId.toLowerCase());

    final prefs = SharedPreferencesUser();
    final Role role = enumFromString(Role.values, prefs.role);
    switch (role) {
      case Role.admin:
        _checkGoToReservationAdminInstructor(reservationStatus, reservation);
        break;

      case Role.instructor:
        _checkGoToReservationAdminInstructor(reservationStatus, reservation);
        break;

      case Role.pilot:
        if (reservationStatus == ReservationStatus.pending || reservationStatus == ReservationStatus.approved) {
          _gotoDetailReservation(context, reservation);
        } else if (reservationStatus == ReservationStatus.readytopay) {
          _checkGoToPay(context,reservation);
        }
        break;

      case Role.student:
      case Role.registered:
        if (reservationStatus == ReservationStatus.pending || reservationStatus == ReservationStatus.approved) {
          _gotoDetailReservation(context, reservation);
        } else if (reservationStatus == ReservationStatus.readytopay) {
          _checkGoToPay(context,reservation);
        }
        break;
    }
  }

  void _checkGoToReservationAdminInstructor(ReservationStatus reservationStatus, Reservation reservation) {
    if (reservationStatus == ReservationStatus.pending) {
      _gotoDetailReservation(context, reservation);
    } else if (reservationStatus == ReservationStatus.approved) {
      if (reservation.aircraft?.serialNoke?.isEmpty ?? false) {
        _gotoCheckFlight(reservation);
      } else {
        _gotoNoke(reservation);
      }
    } else if (reservationStatus == ReservationStatus.flying) {
      _gotoCheckFlight(reservation);
    } else if (reservationStatus == ReservationStatus.finished) {
      _gotoGroundInstruction(context,reservation);
    } else if (reservationStatus == ReservationStatus.readytopay) {
      _checkGoToPay(context,reservation);
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _scheduleBloc.loadSchedule(selectedDay);
    });

  }
  
  void createReservation(BuildContext context) {
    final prefs = SharedPreferencesUser();
    final Role role = enumFromString(Role.values, prefs.role);
    switch (role) {
      case Role.admin:
      case Role.instructor:
      case Role.pilot:
      case Role.student:
        gotoReservationView();
        break;

      case Role.registered:
        showMessage(context, "Error create reservation", "To create a reservation you must upload the documents in your profile.") ;
        break;
    }
  }

  void gotoReservationView() async {
    final DateTime? date = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ReservationView(currentDaySelected: _selectedDay,)),
    );

    if(date != null) {
      setState(() {
        _selectedDay = date;
        _onDaySelected(date, DateTime.now());
      });
    }
  }

  void _gotoDetailReservation(BuildContext context, Reservation reservation) async {
    final result = await Navigator.of(context).pushNamed(DetailReservationView.routeName, arguments: {"reservation": reservation});
    if (result != null && result as bool && result) {
      setState(() {
        _onDaySelected(_selectedDay, DateTime.now());
      });
    }
  }

  void _gotoNoke(Reservation reservation) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NokeView(reservation: reservation, checkSerial: true,)));
    /*final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NokeView(reservation: reservation, checkSerial: true,))) as bool;
    if (result != null && result) {
      setState(() {
        _onDaySelected(_selectedDay, DateTime.now());
      });
    }*/
  }

  void _gotoCheckFlight(Reservation reservation) async {
    final result = await Navigator.of(context).pushNamed(CheckFlightView.routeName, arguments: {"reservation": reservation});
    if (result != null && result as bool && result) {
      setState(() {
        _onDaySelected(_selectedDay, DateTime.now());
      });
    }
  }

  void _gotoGroundInstruction(BuildContext context, Reservation reservation) async {
    final result = await Navigator.of(context).pushNamed(GroundInstructionView.routeName, arguments: {"reservationId": reservation.sId});
    if (result != null && result as bool && result) {
      setState(() {
        _onDaySelected(_selectedDay, DateTime.now());
      });
    }
  }

  void _checkGoToPay(BuildContext context, Reservation reservation) async {
    setState(() {
      _isLoading = true;
    });

    final _paymentApi = PaymentApi();
    final paymentEnabled = await _paymentApi.checkPay();
    setState(() {
      _isLoading = false;
    });

    if(paymentEnabled) {
      _gotoPay(context, reservation);
    }
  }

  void _gotoPay(BuildContext context, Reservation reservation) async {
    setState(() {
      _isLoading = true;
    });

    final _paymentApi = PaymentApi();
    final paymentResponse =
    await _paymentApi.goToPay(reservation?.sId ?? "");
    setState(() {
      _isLoading = false;
    });

    if(paymentResponse != null) {
      if(paymentResponse is Pay) {
        final result = await Navigator.of(context).pushNamed(OpenWebView.routeName, arguments: {"url": paymentResponse.url});
        if (result != null && result as bool && result) {
          setState(() {
            _onDaySelected(_selectedDay, DateTime.now());
          });
        }
      } else if(paymentResponse is String) {
        final String codeError = paymentResponse;
        showMessage(context, "Error pay reservation", codeError);
      }
    } else {
      showMessage(context, "Error Pay", "Error pay reservation.");
    }
  }
}
