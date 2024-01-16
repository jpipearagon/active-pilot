import 'package:aircraft/src/constants/application_colors.dart';
import 'package:aircraft/src/models/Reservation.dart';
import 'package:aircraft/src/noke/NokeManager.dart';
import 'package:aircraft/src/views/check_flight_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'header_view.dart';


class NokeView extends StatefulWidget {

  static final routeName = "nokeView";

  Reservation? reservation;
  bool? checkSerial;

  NokeView({Key? key, this.reservation, this.checkSerial}) : super(key: key);

  @override
  _NokeViewState createState() => _NokeViewState();
}

class _NokeViewState extends State<NokeView> with TickerProviderStateMixin {

  final NokeManager _nokeManager = NokeManager();
  AnimationController? _controller;
  String? _step;
  String? _instruction;
  bool _statusNoke = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_initNoke(widget.reservation);

  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _app(context);
  }

  Widget _app(BuildContext context) {

    final Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: Column(
        children: [
          HeaderView(title: "Smart Lock", subtitle: ""),
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
                    top: 0.0,
                    left: 30.0,
                    right: 30.0
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    )),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Unlock Aircraft",
                        style: GoogleFonts.openSans(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(4, 41, 68, 1)),
                      ),
                      Stack(
                        children: [
                          Lottie.asset(
                              'assets/gifs/lock.json',
                              width: 170,
                              height: 170,
                              controller: _controller,
                              repeat: true
                          ),
                          /*Positioned(
                            top: 123,
                            left: 55,
                            child: Lottie.asset(
                                'assets/gifs/touch-to-screen.json',
                                width: 110,
                                height: 110,
                                repeat: true
                            ),
                          )*/

                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: 20,),
                          Text(
                            "Instructions",
                            style: GoogleFonts.openSans(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(4, 41, 68, 1)),
                          ),
                          RichText(
                            text: TextSpan(
                              text: _step,
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4, 41, 68, 1)),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Enter this code to open the lock",
                                    style: GoogleFonts.openSans(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(4, 41, 68, 1))
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            widget.reservation?.aircraft?.serialNoke ?? "",
                            style: GoogleFonts.openSans(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(4, 41, 68, 1)),
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                      Center(
                        child: ButtonTheme(
                          minWidth: size.width * 0.48,
                          height: size.height * 0.05,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: (_statusNoke) ? Color.fromRGBO(223, 173, 78, 1) : Color.fromRGBO(106,107,108,0.4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.5),
                                  side: BorderSide(color: Colors.transparent)
                              ),
                            ),
                            child: Text(
                              "Unlock",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w700),
                            ),
                            onPressed: (_statusNoke)? () => _unlockNoke(context, widget.reservation): null,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _initNoke(Reservation? reservation) {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 3830));
    _controller?.stop();
    _step = "1. ";
    _instruction = "First step activate the lock from the bottom.";
    _started(reservation);
  }

  Future<Null> _started(Reservation? reservation) async {
    String? serial = "";
    if (reservation != null) {
      serial = reservation.aircraft?.serialNoke;
    }
    Map<dynamic, dynamic> result = await _nokeManager.initNoke(serial ?? "", widget.checkSerial ?? false);
    setState(() {
      if(result["status"] == "Connected") {
        _statusNoke = true;
        _step = "2. ";
        _instruction = "Second step press the unlock button.";
      } else if(result["status"] == "NoSerial") {
        _statusNoke = false;
        _step = "";
        _instruction = result["serial"];
      } else if(result["status"] == "Unlocked") {
        _goToCheckout(reservation);
      }
    });
    return null;
  }

  void _unlockNoke(BuildContext context, Reservation? reservation) async {
    /*String? serial = "";
    if (reservation != null) {
      serial = reservation.aircraft?.serialNoke;
    }
    Map<dynamic, dynamic> result = await _nokeManager.unlockNoke(serial ?? "", widget.checkSerial ?? false);
    */
    setState(() {
      _statusNoke = false;
      _controller?.forward();
      Future.delayed(const Duration(milliseconds: 200), () async {
        _goToCheckout(reservation);
      });
    });
  }

  void _goToCheckout(Reservation? reservation) async {
    //if(widget.checkSerial != null) {
      if(reservation != null) {
        final result = await Navigator.of(context).pushNamed(CheckFlightView.routeName, arguments: {"reservation": reservation});
        if (result != null && result as bool && result) {
          Navigator.of(context).pop(true);
        }
      }
    //} else {
      //Navigator.of(context).pop();
    //}
  }
}
