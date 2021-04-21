import 'package:aircraft/src/Constants/application_colors.dart';
import 'package:aircraft/src/bloc/schedule_bloc.dart';
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
import 'package:table_calendar/table_calendar.dart';

import 'detail_reservation_view.dart';
import 'noke_view.dart';

class ScheduleView extends StatefulWidget {
  static final routeName = "schedule";

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final _calendarController = CalendarController();
  final _scheduleBloc = ScheduleBloc();
  var _selectDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _scheduleBloc.loadSchedule(_selectDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: Column(
        children: [
          HeaderView(title: "Schedule", subtitle: "Choose a date for start"),
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
                      initialSelectedDay: _selectDay,
                      locale: 'en_US',
                      headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleTextStyle: TextStyle(
                              color: Color.fromRGBO(46, 56, 77, 1),
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700)),
                      calendarStyle: CalendarStyle(
                        selectedColor: Color.fromRGBO(255, 204, 0, 0.13),
                        selectedStyle: TextStyle(
                            color: Color.fromRGBO(32, 25, 25, 1),
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        todayColor: Colors.grey,
                        todayStyle: TextStyle(
                            color: Color.fromRGBO(32, 25, 25, 1),
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        weekendStyle: TextStyle(
                            color: Color.fromRGBO(32, 25, 25, 1),
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        weekdayStyle: TextStyle(
                            color: Color.fromRGBO(32, 25, 25, 1),
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        outsideWeekendStyle:
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
                      calendarController: _calendarController,
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
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      Reservation reservation =
                                          snapshot.data[index];
                                      return buildEvent(context, reservation);
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
      case Role.instructor:
        title = "${reservation.pilot.firstName} ${reservation.pilot.lastName}";
        subtitle = "${reservation.activity.name}";
        break;

      case Role.pilot:
        if (prefs.isPilot) {
          title = prefs.flyAlone ? "${reservation.instructor.scheduleName}" : "${reservation.aircraft.name}";
          subtitle = "${reservation.activity.name}";
        }
        break;

      case Role.student:
      case Role.registered:
        title = "${reservation.instructor.scheduleName}";
        subtitle = "${reservation.activity.name}";
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
                        DateUtil.getDateFormattedFromString(reservation.start,
                            DateUtil.yyyyMmddTHHmmssz, DateUtil.HHmm),
                        style: GoogleFonts.montserrat(
                            //fontFamily: "Montserrat",
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(165, 164, 164, 1) // semi-bold
                            ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        DateUtil.getDateFormattedFromString(reservation.end,
                            DateUtil.yyyyMmddTHHmmssz, DateUtil.HHmm),
                        style: GoogleFonts.montserrat(
                            //fontFamily: "Montserrat",
                            fontSize: 12.0,
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
                                  reservation.status.color),
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
                              reservation.status.name,
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
    final ReservationStatus reservationStatus = enumFromString(ReservationStatus.values, reservation.status.name.toLowerCase());

    final prefs = SharedPreferencesUser();
    final Role role = enumFromString(Role.values, prefs.role);
    switch (role) {
      case Role.instructor:
        if (reservationStatus == ReservationStatus.pending) {
          _gotoDetailReservation(context, reservation);
        } else if (reservationStatus == ReservationStatus.approved) {
          _gotoNoke();
        } else if (reservationStatus == ReservationStatus.flying) {

        }
        break;

      case Role.pilot:
        if (reservationStatus == ReservationStatus.pending || reservationStatus == ReservationStatus.approved) {
          _gotoDetailReservation(context, reservation);
        }
        break;

      case Role.student:
      case Role.registered:
        if (reservationStatus == ReservationStatus.pending || reservationStatus == ReservationStatus.approved) {
          _gotoDetailReservation(context, reservation);
        }
        break;
    }
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    _scheduleBloc.loadSchedule(day);
  }
  
  void createReservation(BuildContext context) {
    final prefs = SharedPreferencesUser();
    final Role role = enumFromString(Role.values, prefs.role);
    switch (role) {
      case Role.instructor:
      case Role.pilot:
      case Role.student:
        gotoReservationView();
        break;

      case Role.registered:
        showMessage(context, "Error create reservation", "You do not have permission to create a reservation, contact the administrator.") ;
        break;
    }
  }

  void gotoReservationView() async {
    final DateTime date = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ReservationView()),
    );

    if(date != null) {
      setState(() {
        _selectDay = date;
        _calendarController.setSelectedDay(_selectDay);
        _onDaySelected(date, null, null);
      });
    }
  }

  void _gotoDetailReservation(BuildContext context, Reservation reservation) async {
    final result = await Navigator.of(context).pushNamed(DetailReservationView.routeName, arguments: {"reservation": reservation});
  }

  void _gotoNoke() {
    Navigator.of(context).pushNamed(NokeView.routeName);
  }
}
