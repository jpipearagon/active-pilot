import 'package:aircraft/src/Constants/application_colors.dart';
import 'package:aircraft/src/bloc/schedule_bloc.dart';
import 'package:aircraft/src/models/Reservation.dart';
import 'package:aircraft/src/views/reservation_view.dart';
import 'package:aircraft/utils/colors_util.dart';
import 'package:aircraft/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleView extends StatefulWidget {
  static final routeName = "schedule";

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final _calendarController = CalendarController();
  final _scheduleBloc = ScheduleBloc();

  @override
  void initState() {
    super.initState();
    _scheduleBloc.loadSchedule(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: Column(
        children: [
          Container(
            child: buildTitle(),
          ),
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
                                      return buildEvent(reservation);
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
        onPressed: () => gotoReservation(context),
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(223, 173, 78, 1),
      ),
    );
  }

  Widget buildEvent(Reservation reservation) {
    return Container(
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
                      DateUtil.getDateFormattedFromString(reservation.startDate,
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
                      DateUtil.getDateFormattedFromString(reservation.endDate,
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
                          reservation.pilot,
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
                      reservation.activityType,
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
                                reservation.reservationStatus.color),
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
                            reservation.reservationStatus.name,
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
    );
  }

  Widget buildTitle() {
    double paddingTop = MediaQuery.of(context).padding.top;

    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                top: paddingTop + 10.0,
                bottom: 4.0,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 12.0,
                      color: ApplicationColors().backArrow,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 11.0,
                      ),
                      child: Text(
                        "Schedule",
                        style: GoogleFonts.montserrat(
                            //fontFamily: "Montserrat",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white // semi-bold
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 23.0,
                top: 0.0,
              ),
              child: Text(
                "Choose a date for start",
                style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white // semi-bold
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    _scheduleBloc.loadSchedule(day);
  }
  
  void gotoReservation(BuildContext context) async {
    final bool reloadData = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ReservationView()),
    );

    if(reloadData) {

    }
  }
  
}
