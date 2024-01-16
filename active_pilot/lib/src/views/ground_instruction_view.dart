import 'package:aircraft/src/apis/payment_api.dart';
import 'package:aircraft/src/constants/application_colors.dart';
import 'package:aircraft/src/models/ResponseGeneratePayment.dart';
import 'package:aircraft/src/widgets/message_widget.dart';
import 'package:aircraft/utils/input_done_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import 'header_view.dart';

class GroundInstructionView extends StatefulWidget {
  static final routeName = "ground_view";

  @override
  _GroundInstructionViewState createState() => _GroundInstructionViewState();
}

class _GroundInstructionViewState extends State<GroundInstructionView> {

  final TextEditingController _textEditingControllerGit = TextEditingController();
  final TextEditingController _textEditingControllerSummary = TextEditingController();

  bool _isLoading = false;
  OverlayEntry? overlayEntry;
  String? reservationId;

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    // Subscribe
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (visible) {
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
        progressIndicator: Lottie.asset('assets/gifs/35718-loader.json',
            width: 100, height: 100),
        isLoading: _isLoading,
        child: _app(context));
  }

  Widget _app(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    reservationId = arguments?["reservationId"];

    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: [
            HeaderView(title: "Ground Instruction", subtitle: ""),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  height: double.infinity,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(4, 41, 68, 1)),
                  child: Container(
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0),
                        )),
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height * 0.031,),
                            Text(
                              "Hours:",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(106, 107, 108, 1)),
                            ),
                            SizedBox(height: 8,),
                            TextField(
                                controller: _textEditingControllerGit,
                                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                                textInputAction: TextInputAction.done,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                  ),
                                  hintText: '',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _isValidCheck();
                                  });
                                }
                            ),
                            SizedBox(height: 8,),
                            Text(
                              "Summary",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(106, 107, 108, 1)),
                            ),
                            SizedBox(height: 8,),
                            TextField(
                              controller: _textEditingControllerSummary,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                              maxLines: 4,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                ),
                                hintText: 'Description',
                              ),
                                onChanged: (value) {
                                  setState(() {
                                    _isValidCheck();
                                  });
                                }
                            ),
                            SizedBox(height: size.height * 0.031,),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
            _createButtons()
          ],
        ),
      ),
    );
  }

  Widget _createButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          ButtonTheme(
            minWidth: double.infinity,
            height: 45.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isValidCheck() ? Color.fromRGBO(223, 173, 78, 1) : Color.fromRGBO(106,107,108,0.4),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(18.0),
                    side: BorderSide(
                        color: Colors.transparent)),
              ),
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "Open Sans",
                    fontWeight: FontWeight.w700),
              ),
              onPressed: () => _isValidCheck() ? _saveGround() : null,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ButtonTheme(
            minWidth: double.infinity,
            height: 45.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(223, 173, 78, 1),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(18.0),
                    side: BorderSide(
                        color: Colors.transparent)),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "Open Sans",
                    fontWeight: FontWeight.w700),
              ),
              onPressed: () => _cancel(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void showOverlay() {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0,
          left: 0,
          child: InputDoneView());
    });
    if(overlayEntry != null) {
      overlayState.insert(overlayEntry!);
    }
  }

  void removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  bool _isValidCheck() {
    return _textEditingControllerGit.text.isNotEmpty && _textEditingControllerSummary.text.isNotEmpty;
  }

  void _saveGround() async {

    setState(() {
      _isLoading = true;
    });

    Map<String, String> fields = {
      "reservationId": reservationId ?? "",
      "git": _textEditingControllerGit.text,
      "summary": _textEditingControllerSummary.text,
    };

    final _paymentApi = PaymentApi();
    final paymentResponse =
        await _paymentApi.updateGIT(fields);
    setState(() {
      _isLoading = false;
    });

    if(paymentResponse != null) {
      if(paymentResponse is ResponseGeneratePayment) {
        Navigator.of(context).pop(true);
      } else if(paymentResponse is String) {
        final String codeError = paymentResponse;
        showMessage(context, "Error payment reservation", codeError);
      }
    } else {
      showMessage(context, "Error Payment", "Error payment reservation.");
    }
  }

  void _cancel() {
    Navigator.of(context).pop();
  }
}
