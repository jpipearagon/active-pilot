import 'package:aircraft/src/apis/activities_api.dart';
import 'package:aircraft/src/apis/aircraft_api.dart';
import 'package:aircraft/src/apis/instructor_api.dart';
import 'package:aircraft/src/apis/locations_api.dart';
import 'package:aircraft/src/models/Activities.dart';
import 'package:aircraft/src/models/Aircraft.dart';
import 'package:aircraft/src/models/Locations.dart';
import 'package:aircraft/src/models/UserDetail.dart';
import 'package:aircraft/src/views/select_data_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'confirmation_view.dart';

class ReservationView extends StatefulWidget {

  static final routeName = "reservation";

  @override
  _ReservationViewState createState() => _ReservationViewState();
}

class _ReservationViewState extends State<ReservationView> {

  final TextEditingController _textEditingControllerDateStart = TextEditingController();
  DateTime _chosenDateTimeStart =  DateTime.now();
  final TextEditingController _textEditingControllerDateEnd = TextEditingController();
  DateTime _chosenDateTimeEnd =  DateTime.now().add(Duration(hours: 2));
  var formatter = DateFormat("yyyy/MM/dd HH:mm a");
  String _strLocation = "Select Location";
  LocationUser _locationUser;
  String _strActivity = "Select Activity";
  Activity _activity;
  String _strInstructor = "Select Instructor";
  UserDetail _userDetail;
  String _strAircraft = "Select Aircraft";
  Aircraft _aircraft;
  String _strAircraftRegistration = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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
        isLoading: _isLoading,
        child: _app(context)
    );
  }

  Widget _app(BuildContext context) {

    final size = MediaQuery.of(context).size;

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
                  "Reservation",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 30,
                      fontWeight: FontWeight.w600 ,
                      color: Colors.white// semi-bold
                  )
              ),
              Text(
                  "Please sign in to continue.",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 55,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                              "Start",
                              style: TextStyle(
                                  fontFamily: "Open Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400 ,
                                  color: Color.fromRGBO(4,41,68,1)// semi-bold
                              )
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: _textEditingControllerDateStart,
                            keyboardType: TextInputType.datetime,
                            style: TextStyle(
                              color: Color.fromRGBO(106,107,108,1),
                              fontSize: 14,
                              fontFamily: "Open Sans",
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: formatter.format(_chosenDateTimeStart),
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(106,107,108,1),
                                fontSize: 14,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w400,),
                            ),
                            onTap: () => _selectDateStart(context),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Image(
                          width: 12,
                          height: 19,
                          image: AssetImage("assets/images/down.png"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 27),
                    height: 1,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(238,238,238,1)
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                              "End",
                              style: TextStyle(
                                  fontFamily: "Open Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400 ,
                                  color: Color.fromRGBO(4,41,68,1)// semi-bold
                              )
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: _textEditingControllerDateEnd,
                            keyboardType: TextInputType.datetime,
                            style: TextStyle(
                                color: Color.fromRGBO(106,107,108,1),
                                fontSize: 14,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: formatter.format(_chosenDateTimeEnd),
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(106,107,108,1),
                                fontSize: 14,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w400,),
                            ),
                            onTap: () => _selectDateEnd(context),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Image(
                          width: 12,
                          height: 19,
                          image: AssetImage("assets/images/down.png"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 27),
                    height: 1,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(238,238,238,1)
                    ),
                  ),
                  showErrorEndDate(),
                  SizedBox(
                    height: size.height * 0.0625,
                  ),
                  Text(
                      "Location",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w600 ,
                          color: Color.fromRGBO(4,41,68,1)// semi-bold
                      )
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Color.fromRGBO(106,107,108,1),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Text(
                                _strLocation,
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400 ,
                                    color: Color.fromRGBO(4,41,68,1)// semi-bold
                                )
                            ),
                          ),
                          Image(
                            width: 12,
                            height: 19,
                            image: AssetImage("assets/images/down.png"),
                          )
                        ],
                      ),
                    ),
                    onTap: () => _showData(Types.location),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 27),
                    height: 1,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(238,238,238,1)
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.029,
                  ),
                  Text(
                      "Activity",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w600 ,
                          color: Color.fromRGBO(4,41,68,1)// semi-bold
                      )
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Icon(
                            Icons.accessibility,
                            color: Color.fromRGBO(106,107,108,1),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Text(
                                _strActivity,
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400 ,
                                    color: Color.fromRGBO(4,41,68,1)// semi-bold
                                )
                            ),
                          ),
                          Image(
                            width: 12,
                            height: 19,
                            image: AssetImage("assets/images/down.png"),
                          )
                        ],
                      ),
                    ),
                    onTap: () => _showData(Types.activity),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 27),
                    height: 1,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(238,238,238,1)
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.029,
                  ),
                  Text(
                      "Instructor",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w600 ,
                          color: Color.fromRGBO(4,41,68,1)// semi-bold
                      )
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Color.fromRGBO(106,107,108,1),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Text(
                                _strInstructor,
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400 ,
                                    color: Color.fromRGBO(4,41,68,1)// semi-bold
                                )
                            ),
                          ),
                          Image(
                            width: 12,
                            height: 19,
                            image: AssetImage("assets/images/down.png"),
                          )
                        ],
                      ),
                    ),
                    onTap: isAvailableInstructor() ? () => _showData(Types.instructor) : null,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 27),
                    height: 1,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(238,238,238,1)
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.029,
                  ),
                  Text(
                      "Aircraft",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w600 ,
                          color: Color.fromRGBO(4,41,68,1)// semi-bold
                      )
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Icon(
                            Icons.airplanemode_active,
                            color: Color.fromRGBO(106,107,108,1),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    _strAircraftRegistration,
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600 ,
                                        color: Color.fromRGBO(0,0,0,1)// semi-bold
                                    )
                                ),
                                Text(
                                    _strAircraft,
                                    style: TextStyle(
                                        fontFamily: "Open Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400 ,
                                        color: Color.fromRGBO(0,0,0,1)// semi-bold
                                    )
                                ),
                              ],
                            ),
                          ),
                          Image(
                            width: 12,
                            height: 19,
                            image: AssetImage("assets/images/down.png"),
                          )
                        ],
                      ),
                    ),
                    onTap: isAvailableAircraft() ? () => _showData(Types.aircraft) : null,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 27),
                    height: 1,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(238,238,238,1)
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.073,
                  ),
                  Center(
                    child: ButtonTheme(
                      minWidth: size.width * 0.48,
                      height: size.height * 0.064,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.5),
                            side: BorderSide(color: Colors.transparent)
                        ),
                        color: isCompletedReservation() ? Color.fromRGBO(223, 173, 78, 1) : Color.fromRGBO(106,107,108,1),
                        child: Text(
                          "Continue ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: "Open Sans",
                              fontWeight: FontWeight.w400),
                        ),
                        onPressed: isCompletedReservation() ? () => continueReservation(context) : null,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.073,
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }


  Future<Null> _selectDateStart(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    final contentHeight = size.height/2;
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: contentHeight,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              // Close the modal
              CupertinoButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Container(
                height: contentHeight*0.8,
                child: CupertinoDatePicker(
                    initialDateTime: _chosenDateTimeStart,
                    onDateTimeChanged: (val) {
                      setState(() {
                        _chosenDateTimeStart = val;
                        _textEditingControllerDateStart.text = formatter.format(_chosenDateTimeStart);
                      });
                    }),
              )
            ],
          ),
        )
    );
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    final contentHeight = size.height/2;
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: contentHeight,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              // Close the modal
              CupertinoButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Container(
                height: contentHeight*0.8,
                child: CupertinoDatePicker(
                    initialDateTime: _chosenDateTimeEnd,
                    onDateTimeChanged: (val) {
                      setState(() {
                        _chosenDateTimeEnd = val;
                        _textEditingControllerDateEnd.text = formatter.format(_chosenDateTimeEnd);
                      });
                    }),
              )
            ],
          ),
        )
    );
  }

  Widget showErrorEndDate() {
    final statusDate = _chosenDateTimeStart.isBefore(_chosenDateTimeEnd);
    if (statusDate) {
      return Container();
    } else {
      return Text(
          "Please select a date greater than the initial one ",
          style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 12,
              fontWeight: FontWeight.w600 ,
              color: Colors.red[600]
          )
      );
    }
  }


  void _showData(Types type) async {

    setState(() {
      _isLoading = true;
    });

    if(type == Types.location) {
      final locationApi = LocationsApi();
      final locations = await locationApi.getLocations();
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SelectDataView(type: type,
                data: locations,
                onTap: (type, data) => _selectData(type, data),),
            );
          });
    }

    if(type == Types.activity) {
      final activitiesApi = ActivitiesApi();
      final activities = await activitiesApi.getActivities();
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SelectDataView(type: type,
                data: activities,
                onTap: (type, data) => _selectData(type, data),),
            );
          });
    }

    if(type == Types.instructor) {
      final instructorsApi = InstructorApi();
      final instructors = await instructorsApi.getAvailableInstructor(_chosenDateTimeStart.toIso8601String(), _chosenDateTimeEnd.toIso8601String(), _locationUser.id);
      setState(() {
        _isLoading = false;
      });
      if(instructors != null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: SelectDataView(type: type,
                  data: instructors,
                  onTap: (type, data) => _selectData(type, data),),
              );
            });
      }
    }

    if(type == Types.aircraft) {

      final aircraftApi = AircraftApi();
      final aircrafts = await aircraftApi.getAvailableAircrafts(_chosenDateTimeStart.toIso8601String(), _chosenDateTimeEnd.toIso8601String(), _locationUser.id, _activity.id, _userDetail.pilot.aircraftCategory);
      setState(() {
        _isLoading = false;
      });
      if(aircrafts != null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: SelectDataView(type: type,
                  data: aircrafts,
                  onTap: (type, data) => _selectData(type, data),),
              );
            });
      }
    }

  }

  void _selectData(Types type, dynamic dataSelect) {
    if(type == Types.location) {
      _locationUser = dataSelect;
      setState(() {
        _strLocation = _locationUser.name;
      });
    }
    if(type == Types.activity) {
      _activity = dataSelect;
      setState(() {
        _strActivity = _activity.name;
      });
    }
    if(type == Types.instructor) {
      _userDetail = dataSelect;
      setState(() {
        _strInstructor = "${_userDetail.firstName} ${_userDetail.lastName}";
      });
    }
    if(type == Types.aircraft) {
      _aircraft = dataSelect;
      setState(() {
        _strAircraft = "${_aircraft.aircraftModel.name} ${_aircraft.aircraftMaker.name}";
        _strAircraftRegistration = "${_aircraft.registrationTail}";
      });
    }
  }

  bool isAvailableInstructor() {
    final statusDate = _chosenDateTimeStart.isBefore(_chosenDateTimeEnd);
    return statusDate && _locationUser != null;
  }

  bool isAvailableAircraft() {
    final statusDate = _chosenDateTimeStart.isBefore(_chosenDateTimeEnd);
    return statusDate && _locationUser != null && _activity != null;
  }

  bool isCompletedReservation() {
    final statusDate = _chosenDateTimeStart.isBefore(_chosenDateTimeEnd);
    return statusDate && _locationUser != null && _activity != null && _userDetail != null && _aircraft != null;
  }

  void continueReservation( BuildContext context) async {
    final reservationData = {
      "startDate": _chosenDateTimeStart,
      "endDate": _chosenDateTimeEnd,
      "activityId" : _activity.id,
      "instructorId": _userDetail.id,
      "aircraftId": _aircraft.id,
    };


    final DateTime date = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ConfirmationView(reservationData: reservationData,)),
    );

    if (date != null) {
      Navigator.of(context).pop(date);
    }
  }

}
