import 'package:aircraft/src/bloc/user_bloc.dart';
import 'package:aircraft/src/models/LogBook.dart';
import 'package:aircraft/src/views/logbook_edit_view.dart';
import 'package:aircraft/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'schedule_view.dart';

class LogBookView extends StatefulWidget {
  LogBookView({
    Key? key,
  }) : super(key: key);

  @override
  _LogBookViewState createState() => _LogBookViewState();
}

class _LogBookViewState extends State<LogBookView> {
  final _userBloc = UserBloc();

  @override
  void initState() {
    super.initState();
    _userBloc.loadLogBook();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: StreamBuilder<List<LogBook>>(
        stream: _userBloc.logBookStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if ((snapshot.data?.length ?? 0 )> 0) {
              return ListView.builder(
                key: Key("logbook"),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  LogBook? logBook = snapshot.data?[index];
                  if(logBook != null) {
                    return _buildLogBookItemRow(logBook);
                  }
                },
              );
            } else {
              return Container(
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "No Flight History Recorded",
                      style: GoogleFonts.openSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(4, 41, 68, 1) // semi-bold
                      ),
                    ),
                    SizedBox(height: 50,),
                    Center(
                      child: ButtonTheme(
                        minWidth: size.width * 0.6,
                        height: size.height * 0.064,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(223, 173, 78, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.5),
                                side: BorderSide(color: Colors.transparent)
                            ),
                          ),
                          child: Text(
                            "Schedule First Flight",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () {
                              Navigator.of(context).pushNamed(ScheduleView.routeName);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text(
                  "Error load logbook",
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
      ),
    );
  }

  Widget _buildLogBookItem(LogBook logBook) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 21),
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(238, 238, 238, 1)),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Aircraft: ",
                  style: TextStyle(
                      color: Color.fromRGBO(4, 41, 68, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "${logBook.aircraft?.name}",
                  style: TextStyle(
                      color: Color.fromRGBO(106, 107, 108, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Activity: ",
                  style: TextStyle(
                      color: Color.fromRGBO(4, 41, 68, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  logBook.activity?.name ?? "",
                  style: TextStyle(
                      color: Color.fromRGBO(106, 107, 108, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Date: ",
                  style: TextStyle(
                      color: Color.fromRGBO(4, 41, 68, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  DateUtil.getDateFormattedFromString(
                      logBook.creationDate ?? "", DateUtil.ddMMyyyy),
                  style: TextStyle(
                      color: Color.fromRGBO(106, 107, 108, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Instructor: ",
                  style: TextStyle(
                      color: Color.fromRGBO(4, 41, 68, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "${logBook.instructor?.instructor?.scheduleName}",
                  style: TextStyle(
                      color: Color.fromRGBO(106, 107, 108, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Student: ",
                  style: TextStyle(
                      color: Color.fromRGBO(4, 41, 68, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "${logBook.pilot?.fullName}",
                  style: TextStyle(
                      color: Color.fromRGBO(106, 107, 108, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Hoobs: ",
                  style: TextStyle(
                      color: Color.fromRGBO(4, 41, 68, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "${logBook.hoobs?.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Color.fromRGBO(106, 107, 108, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        _gotoUpdateLogbook(logBook);
      },
    );
  }

  Widget _buildLogBookItemRow(LogBook logBook) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(238, 238, 238, 1)),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Date ",
                  style: TextStyle(
                      color: Color.fromRGBO(4, 41, 68, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  DateUtil.getDateFormattedFromString(
                      logBook.creationDate ?? "", DateUtil.MMMddyyyy),
                  style: TextStyle(
                      color: Color.fromRGBO(106, 107, 108, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 1,
              decoration: BoxDecoration(
                color: Color.fromRGBO(238, 238, 238, 1))
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Aircraft",
                        style: TextStyle(
                            color: Color.fromRGBO(4, 41, 68, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${logBook.aircraft?.registrationTail}",
                        style: TextStyle(
                            color: Color.fromRGBO(106, 107, 108, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "From",
                        style: TextStyle(
                            color: Color.fromRGBO(4, 41, 68, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${logBook.from}",
                        style: TextStyle(
                            color: Color.fromRGBO(106, 107, 108, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "To",
                        style: TextStyle(
                            color: Color.fromRGBO(4, 41, 68, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${logBook.to}",
                        style: TextStyle(
                            color: Color.fromRGBO(106, 107, 108, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Hoobs",
                        style: TextStyle(
                            color: Color.fromRGBO(4, 41, 68, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${logBook.hoobs?.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Color.fromRGBO(106, 107, 108, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        _gotoUpdateLogbook(logBook);
      },
    );
  }

  void _gotoUpdateLogbook(LogBook logBook) async {
    await Navigator.of(context)
        .pushNamed(LogBookEditView.routeName, arguments: {"logBook": logBook});
    _userBloc.loadLogBook();
  }

  String _formatDouble(double value) {
    //this also rounds (so 0.8999999999999999 becomes '0.9000')
    var verbose = value.toStringAsFixed(4);
    var trimmed = verbose;
    //trim all trailing 0's after the decimal point (and the decimal point if applicable)
    for (var i = verbose.length - 1; i > 0; i--) {
      if (trimmed[i] != '0' && trimmed[i] != '.' || !trimmed.contains('.')) {
        break;
      }
      trimmed = trimmed.substring(0, i);
    }
    return trimmed;
  }
}
