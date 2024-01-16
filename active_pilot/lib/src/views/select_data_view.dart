import 'package:aircraft/src/models/Activities.dart';
import 'package:aircraft/src/models/Aircraft.dart';
import 'package:aircraft/src/models/Locations.dart';
import 'package:aircraft/src/models/ProfileCountry.dart';
import 'package:aircraft/src/models/UserDetail.dart';
import 'package:aircraft/src/views/aircraft_detail_view.dart';
import 'package:flutter/material.dart';

enum Types { location, activity, instructor, aircraft, country }

class SelectDataView extends StatefulWidget {

  final Function onTap;
  final Types type;
  final List<dynamic> data;
  SelectDataView({Key? key, required this.data, required this.type, required this.onTap}) : super(key: key);

  @override
  _SelectDataViewState createState() => _SelectDataViewState();
}

class _SelectDataViewState extends State<SelectDataView> {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    var width = 0.0;
    var height = 0.0 ;

    if (widget.type == Types.aircraft) {
      width = size.width ;
      height = size.height - 100;
    } else {
      width = size.width - 100;
      height = size.height - 300;
    }

    return Container(
      width: width,
      height: height,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          if (widget.type == Types.aircraft) {
            return Container(height: 20,);
          } else {
            return Divider(color: Colors.blueGrey[50]);
          }
        },
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          if (widget.type == Types.aircraft) {
            return _cardAircraft(widget.data[index]);
          } else {
            return _cell(context, widget.data[index]);
          }
        },
      ),
    );
  }

  Widget _cardAircraft(dynamic data) {
    Aircraft aircraft = data;

    Widget image;
    if((aircraft.photos?.length ?? 0) > 0 ) {
      image = Image(
        width: 50,
        height: 50,
        image: NetworkImage("${aircraft.photos?[0].url}"),
      );
    } else {
      image = Icon(
        Icons.location_on,
        color: Color.fromRGBO(106,107,108,1),
      );
    }

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("${aircraft.registrationTail}",
              style: TextStyle(
                  color: Color.fromRGBO(0,0,0,1),
                  fontSize: 14,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Text("${aircraft.aircraftModel?.name} ${aircraft.aircraftMaker?.name}",
              style: TextStyle(
                  color: Color.fromRGBO(0,0,0,1),
                  fontSize: 14,
                  fontFamily: "Open Sans",
                  fontWeight: FontWeight.w400),
            ),
            leading: image,
          ),
          Divider(
            color: Colors.grey[400],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 20,),
              Expanded(
                child: GestureDetector(
                  child: Text("More Details",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromRGBO(0,0,0,1),
                          fontSize: 12,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w400)),
                  onTap: () {
                    Navigator.of(context).pushNamed(AircraftDetailView.routeName, arguments: {"aircraft": aircraft});
                  },
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: ButtonTheme(
                  height: 25.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(223, 173, 78, 1), // background
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.transparent)
                      ),
                    ),
                    child: Text(
                      "Select",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onTap(widget.type, aircraft);
                    },
                  ),
                ),
              ),
              SizedBox(width: 20,),
            ],
          )
        ],
      ),
    );
  }

  Widget _cell(BuildContext context, dynamic data) {


    if (widget.type == Types.location) {
      LocationUser location = data;
      return ListTile(
        title: Text(
            location?.name ?? ""
        ),
        onTap: () {
          Navigator.pop(context);
          widget.onTap(widget.type, location);
        },
      );
    }

    if (widget.type == Types.activity) {
      Activity activity = data;
      return ListTile(
          title: Text(
              activity.name
          ),
          onTap: () {
            Navigator.pop(context);
            widget.onTap(widget.type, activity);
          }
      );
    }

    if (widget.type == Types.instructor) {
      UserDetail user = data;
      return ListTile(
          title: Text(
              "${user.firstName} ${user.lastName}"
          ),
          onTap: () {
            Navigator.pop(context);
            widget.onTap(widget.type, user);
          }
      );
    }

    if (widget.type == Types.country) {
      ProfileCountry location = data;
      return ListTile(
        title: Text(
            location?.name ?? ""
        ),
        onTap: () {
          Navigator.pop(context);
          widget.onTap(widget.type, location);
        },
      );
    }

    return Container();
  }
}
