import 'package:aircraft/src/apis/user_detail_api.dart';
import 'package:aircraft/src/constants/application_colors.dart';
import 'package:aircraft/src/models/LogBook.dart';
import 'package:aircraft/src/widgets/message_widget.dart';
import 'package:aircraft/utils/date_util.dart';
import 'package:aircraft/utils/input_done_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import 'header_view.dart';

class LogBookEditView extends StatefulWidget {

  static final routeName = "logbook_edit_view";

  @override
  _LogBookEditViewState createState() => _LogBookEditViewState();
}

class _LogBookEditViewState extends State<LogBookEditView> {

  final TextEditingController _textEditingControllerFrom = TextEditingController();
  final TextEditingController _textEditingControllerTo = TextEditingController();
  final TextEditingController _textEditingControllerDF = TextEditingController();
  final TextEditingController _textEditingControllerPic = TextEditingController();
  final TextEditingController _textEditingControllerDual = TextEditingController();
  final TextEditingController _textEditingControllerSolo = TextEditingController();
  final TextEditingController _textEditingControllerAs = TextEditingController();
  final TextEditingController _textEditingControllerGIT = TextEditingController();
  final TextEditingController _textEditingControllerIFRS = TextEditingController();
  final TextEditingController _textEditingControllerIFRC = TextEditingController();
  final TextEditingController _textEditingControllerNight = TextEditingController();
  final TextEditingController _textEditingControllerCross = TextEditingController();
  final TextEditingController _textEditingControllerHold = TextEditingController();
  final TextEditingController _textEditingControllerAppro = TextEditingController();
  final TextEditingController _textEditingControllerToDay = TextEditingController();
  final TextEditingController _textEditingControllerToNight = TextEditingController();
  final TextEditingController _textEditingControllerLandings = TextEditingController();

  bool _isLoading = false;
  LogBook? _logBook;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    // Subscribe
    keyboardVisibilityController.onChange.listen((bool visible) {
      if(visible) {
        showOverlay();
      } else {
        removeOverlay();
      }
    });
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
    final Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    LogBook logBook = arguments?["logBook"];
    _loadLogBook(logBook);

    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: [
            HeaderView(title: "Logbook Detail", subtitle: ""),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(4, 41, 68, 1)
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0),
                        )
                    ),
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Aircraft: ",
                                  style: TextStyle(
                                      color: Color.fromRGBO(4,41,68,1),
                                      fontSize: 14,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w700),),
                                Text("${_logBook?.aircraft?.name}",
                                  style: TextStyle(
                                      color: Color.fromRGBO(106,107,108,1),
                                      fontSize: 14,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w400),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Activity: ",
                                  style: TextStyle(
                                      color: Color.fromRGBO(4,41,68,1),
                                      fontSize: 14,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w700),),
                                Text("${_logBook?.activity?.name}",
                                  style: TextStyle(
                                      color: Color.fromRGBO(106,107,108,1),
                                      fontSize: 14,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w400),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Date: ",
                                  style: TextStyle(
                                      color: Color.fromRGBO(4,41,68,1),
                                      fontSize: 14,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w700),),
                                Text(DateUtil.getDateFormattedFromString(_logBook?.creationDate ?? "", DateUtil.yyyyMMdd),
                                  style: TextStyle(
                                      color: Color.fromRGBO(106,107,108,1),
                                      fontSize: 14,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w400),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Instructor: ",
                                  style: TextStyle(
                                      color: Color.fromRGBO(4,41,68,1),
                                      fontSize: 14,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w700),),
                                Text("${_logBook?.instructor?.instructor?.scheduleName}",
                                  style: TextStyle(
                                      color: Color.fromRGBO(106,107,108,1),
                                      fontSize: 14,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w400),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Student: ",
                                  style: TextStyle(
                                      color: Color.fromRGBO(4,41,68,1),
                                      fontSize: 14,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w700),),
                                Text("${_logBook?.pilot?.fullName}",
                                  style: TextStyle(
                                      color: Color.fromRGBO(106,107,108,1),
                                      fontSize: 14,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w400),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Hoobs: ",
                                  style: TextStyle(
                                      color: Color.fromRGBO(4,41,68,1),
                                      fontSize: 14,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w700),),
                                Text("${_logBook?.hoobs}",
                                  style: TextStyle(
                                      color: Color.fromRGBO(106,107,108,1),
                                      fontSize: 14,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w400),),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "From",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerFrom,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "To",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerTo,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Duration of Flight",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(4,41,68,1)),
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  enabled: false,
                                  controller: _textEditingControllerDF,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                  maxLines: 1,
                                  decoration: new InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                    ),
                                    fillColor: Color.fromRGBO(238, 238, 238, 1),
                                    filled: true,
                                    hintText: '',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height*0.023,),
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(106,107,108,1)
                              ),
                            ),
                            SizedBox(height: size.height*0.023,),
                            Text(
                              "Training",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: size.height*0.023,),
                            Text(
                              "Crosscountry",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerCross,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "PIC",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerPic,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Flight Training Receive",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerDual,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "SOLO",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerSolo,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "AS CFI",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerAs,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: size.height*0.023,),
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(106,107,108,1)
                              ),
                            ),
                            SizedBox(height: size.height*0.023,),
                            Text(
                              "Conditions of Flight",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: size.height*0.023,),
                            Text(
                              "GIT (Ground Training Received)",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerGIT,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            Text(
                              "IFR Simulated",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerIFRS,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "IFR Current",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerIFRC,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Night",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerNight,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: size.height*0.023,),
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(106,107,108,1)
                              ),
                            ),
                            SizedBox(height: size.height*0.023,),
                            Text(
                              "Currency",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: size.height*0.023,),
                            Text(
                              "Holdings",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerHold,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Approaches",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerAppro,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "TO/LDG Day",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerToDay,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "TO/LDG Night",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(4,41,68,1)),
                            ),
                            SizedBox(height: 10,),
                            TextField(
                              controller: _textEditingControllerToNight,
                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: '',
                              ),
                            ),
                            SizedBox(height: size.height*0.033,),
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
                                    "Update",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: "Open Sans",
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onPressed: () {
                                    _updateLogBook();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: size.height*0.033,),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateLogBook() async {
    Map<String, String> params = {};

    if(_textEditingControllerFrom.text != _logBook?.from) {
      params["from"] = _textEditingControllerFrom.text;
    }

    if(_textEditingControllerTo.text != _logBook?.to) {
      params["to"] = _textEditingControllerTo.text;
    }

    if(_textEditingControllerPic.text != _logBook?.pic) {
      params["pic"] = _textEditingControllerPic.text;
    }

    if(_textEditingControllerDual.text != _logBook?.dual) {
      params["dual"] = _textEditingControllerDual.text;
    }

    if(_textEditingControllerSolo.text != _logBook?.solo) {
      params["solo"] = _textEditingControllerSolo.text;
    }

    if(_textEditingControllerAs.text != _logBook?.adCfi) {
      params["adCfi"] = _textEditingControllerAs.text;
    }

    if(_textEditingControllerGIT.text != "${_logBook?.git}") {
      params["git"] = _textEditingControllerGIT.text;
    }

    if(_textEditingControllerIFRS.text != _logBook?.ifr) {
      params["ifr"] = _textEditingControllerIFRS.text;
    }

    if(_textEditingControllerIFRC.text != _logBook?.ifrActual) {
      params["ifrActual"] = _textEditingControllerIFRC.text;
    }

    if(_textEditingControllerNight.text != "${_logBook?.night}") {
      params["night"] = _textEditingControllerNight.text;
    }

    if(_textEditingControllerCross.text != "${_logBook?.crossCountry}") {
      params["crossCountry"] = _textEditingControllerCross.text;
    }

    if(_textEditingControllerHold.text != "${_logBook?.holdings}") {
      params["holdings"] = _textEditingControllerHold.text;
    }

    if(_textEditingControllerAppro.text != "${_logBook?.approaches}") {
      params["approaches"] = _textEditingControllerAppro.text;
    }

    if(_textEditingControllerToDay.text != "${_logBook?.toDay}") {
      params["toDay"] = _textEditingControllerToDay.text;
    }

    if(_textEditingControllerToNight.text != "${_logBook?.toNight}") {
      params["toNight"] = _textEditingControllerToNight.text;
    }

    if(_textEditingControllerLandings.text != "${_logBook?.landings}") {
      params["landings"] = _textEditingControllerLandings.text;
    }

    if(params.length > 0 ) {
      setState(() {
        _isLoading = true;
      });

      final userDetailApi = UserDetailApi();
      final response = await userDetailApi.updateLogBook(_logBook?.sId ?? "", params);

      setState(() {
        _isLoading = false;
      });

      if(response != null) {
        if(response is LogBook) {
          await futureShowMessage(context, "Successful update", "It was updated correctly.");
          Navigator.pop(context);
        } else if(response is String) {
          final String codeError = response;
          showMessage(context, "Error update logbook", codeError);
        }
      } else {
        showMessage(context, "Error Update", "Error update logbook.");
      }
    }
  }

  void showOverlay() {
    if(overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0,
          left: 0,
          child: InputDoneView()
      );
    });

    overlayState.insert(overlayEntry!);
  }

  void removeOverlay() {
    if(overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  void _loadLogBook(LogBook logBook) {
    if(_logBook == null) {
      _logBook = logBook;
      _textEditingControllerFrom.text = _logBook?.from ?? "";
      _textEditingControllerTo.text = _logBook?.to ?? "";
      _textEditingControllerDF.text = "${_logBook?.hoobs}";
      _textEditingControllerPic.text = _logBook?.pic ?? "";
      _textEditingControllerDual.text = _logBook?.dual ?? "";
      _textEditingControllerSolo.text = _logBook?.solo ?? "";
      _textEditingControllerAs.text = _logBook?.adCfi ?? "";
      _textEditingControllerGIT.text = "${_logBook?.git}";
      _textEditingControllerIFRS.text = _logBook?.ifr ?? "";
      _textEditingControllerIFRC.text = _logBook?.ifrActual ?? "";
      _textEditingControllerNight.text = "${_logBook?.night}";
      _textEditingControllerCross.text = "${_logBook?.crossCountry}";
      _textEditingControllerHold.text = "${_logBook?.holdings}";
      _textEditingControllerAppro.text = "${_logBook?.approaches}";
      _textEditingControllerToDay.text = "${_logBook?.toDay}";
      _textEditingControllerToNight.text = "${_logBook?.toNight}";
      _textEditingControllerLandings.text = "${_logBook?.landings}";
    }
  }
}
