import 'package:aircraft/src/views/noke_view.dart';
import 'package:aircraft/src/views/reservation_view.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleView extends StatefulWidget {

  static final routeName = "schedule";

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {

  final _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
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
                  "Schedule",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 30,
                      fontWeight: FontWeight.w600 ,
                      color: Colors.white// semi-bold
                  )
              ),
              Text(
                  "Choose a date for start",
                  style: TextStyle(
                      fontFamily: "Open Sans",
                      fontSize: 14,
                      fontWeight: FontWeight.w400 ,
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
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                )
            ),
            child: Column(
              children: [
                TableCalendar(
                  locale: 'en_US',
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                          color: Color.fromRGBO(46,56,77,1),
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700
                      )
                  ),
                  calendarStyle: CalendarStyle(
                      selectedColor: Color.fromRGBO(255,204,0,0.13),
                      selectedStyle: TextStyle(
                          color: Color.fromRGBO(32,25,25,1),
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                      ),
                      todayColor: Color.fromRGBO(255,204,0,0.13),
                      todayStyle: TextStyle(
                          color: Color.fromRGBO(32,25,25,1),
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                      ),
                      weekendStyle: TextStyle(
                          color: Color.fromRGBO(32,25,25,1),
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                      ),
                      weekdayStyle: TextStyle(
                          color: Color.fromRGBO(32,25,25,1),
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                      ),
                      outsideWeekendStyle: TextStyle(color: const Color(0xFF9E9E9E)),

                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: Color.fromRGBO(186,186,186,1),
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600
                    ),
                    weekendStyle: TextStyle(
                        color: Color.fromRGBO(186,186,186,1),
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  calendarController: _calendarController,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(238,238,238,1)
                    ),
                    child: ListView(
                      children: _events(context),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ReservationView.routeName);
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(223,173,78,1),
      ),
    );
  }

  List<Widget> _events(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return events.map((event) {
      return ListTile(
        title: Container(

          child: Column(
            children: [
              SizedBox(height: 12,),
              Row(
                children: [
                  Column(
                    children: [
                      Text(event.startDate,
                        style: TextStyle(
                            color: Color.fromRGBO(165,164,164,1),
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),),
                      SizedBox(height: 5,),
                      Text(event.endDate,
                        style: TextStyle(
                            color: Color.fromRGBO(165,164,164,1),
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),),
                    ],
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Container(
                    width: 1,
                    height: size.height*0.078,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(106,107,108,1)
                    ),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.event,
                        style: TextStyle(
                            color: Color.fromRGBO(4,41,68,1),
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500),),
                      SizedBox(height: 5,),
                      Text(event.eventType,
                        style: TextStyle(
                            color: Color.fromRGBO(4,41,68,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),),
                    ],
                  ),

                ],
              ),
              SizedBox(height: 12,),
              Container(
                height: 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(106,107,108,1)
                ),
              ),

            ],
          )
        ),
        onTap: () {
          Navigator.of(context).pushNamed(NokeView.routeName);
        },
      );
    }).toList();
  }

}

final List<Event> events = [
  Event(1, '09:30', "10:30", "Andrew Mayor Duke", "Event Type",),
  Event(2, '09:30', "10:30", "Andrew Mayor Duke", "Event Type",),
  Event(3, '09:30', "10:30", "Andrew Mayor Duke", "Event Type",),
  Event(4, '09:30', "10:30", "Andrew Mayor Duke", "Event Type",),
  Event(5, '09:30', "10:30", "Andrew Mayor Duke", "Event Type",),
];

class Event {
  int tag;
  String startDate;
  String endDate;
  String event;
  String eventType;

  Event(this.tag,
      this.startDate,
      this.endDate,
      this.event,
      this.eventType,
      );
}

