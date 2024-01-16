import 'dart:io';

import 'package:aircraft/src/apis/payment_api.dart';
import 'package:aircraft/src/apis/reservation_api.dart';
import 'package:aircraft/src/constants/application_colors.dart';
import 'package:aircraft/src/models/CheckinResponse.dart';
import 'package:aircraft/src/models/CheckoutResponse.dart';
import 'package:aircraft/src/models/ImageFile.dart';
import 'package:aircraft/src/models/Reservation.dart';
import 'package:aircraft/src/models/ReservationStatus.dart';
import 'package:aircraft/src/models/ResponseGeneratePayment.dart';
import 'package:aircraft/src/models/UserRole.dart';
import 'package:aircraft/src/models/ValidationReservation.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:aircraft/src/widgets/message_widget.dart';
import 'package:aircraft/utils/input_done_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'header_view.dart';
import 'noke_view.dart';


enum CheckType { checkout, checkin }
enum CheckFileType { hoobs, tach, fuel, discrepancy }

class CheckFlightView extends StatefulWidget {

  static final routeName = "check_fligth";

  @override
  _CheckFlightViewState createState() => _CheckFlightViewState();
}

class _CheckFlightViewState extends State<CheckFlightView> {

  final TextEditingController _textEditingControllerHoobs = TextEditingController();
  final TextEditingController _textEditingControllerTach = TextEditingController();
  final TextEditingController _textEditingControllerFuel = TextEditingController();
  final TextEditingController _textEditingControllerOil = TextEditingController();
  final TextEditingController _textEditingControllerDiscrepancy = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  PickedFile? _imageHoobs;
  PickedFile? _imageTach;
  PickedFile? _imageFuel;
  List<PickedFile> _listDiscrepancy = [];
  CheckType? _checkType;
  int _currentImage = 0;
  Reservation? reservation;
  OverlayEntry? overlayEntry;
  String title = "";
  String button = "";
  String hoobsLabel = "";
  String tachLabel = "";
  String discrepancyDetail = "* Add discrepancy is required";

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
    _loadReservation(context);
    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
        child: Column(
          children: [
            HeaderView(title: title, subtitle: ""),
            Expanded(
              child: Container(
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
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(top: size.height * 0.065, left: size.width * 0.12, right: size.width * 0.12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Upload images",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(223, 173, 78, 1)),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    reservation?.aircraft?.name ?? "",
                                    softWrap: true,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(4, 41, 68, 1)),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: size.height*0.043,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  hoobsLabel,
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(106, 107, 108, 1)),
                                ),
                                _checkImageHoobs()
                              ],
                            ),
                            SizedBox(height: 8,),
                            TextField(
                              controller: _textEditingControllerHoobs,
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
                              onChanged: (value) {
                                setState(() {
                                  _isValidCheck();
                                });
                              },
                            ),
                            SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tachLabel,
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(106, 107, 108, 1)),
                                ),
                                _checkImageTach()
                              ],
                            ),
                            SizedBox(height: 8,),
                            TextField(
                                controller: _textEditingControllerTach,
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
                            _getFuelWidget(),
                            _getOilWidget(),
                            SizedBox(height: size.height * 0.031,),
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(238, 238, 238, 1)
                              ),
                            ),
                            SizedBox(height: size.height * 0.031,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Discrepancy  images",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(106, 107, 108, 1)),
                                ),
                                InkWell(
                                  child: Icon(
                                      Icons.add_a_photo,
                                      color: Color.fromRGBO(4, 41, 68, 1)
                                  ),
                                  onTap: () => _showPicker(context, CheckFileType.discrepancy),
                                )
                              ],
                            ),
                            SizedBox(height: 8,),
                            TextField(
                              controller: _textEditingControllerDiscrepancy,
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
                            Visibility(
                              child: Text(
                                discrepancyDetail,
                                style: GoogleFonts.openSans(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red),
                              ),
                              visible: _showDiscrepancy(),
                            ),
                            SizedBox(height: size.height * 0.031,),
                            Text(
                              "Images selected",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(106, 107, 108, 1)),
                            ),
                            SizedBox(height: size.height * 0.031,),
                            _uploadImagesWidget(size),
                            SizedBox(height: size.height * 0.05,),
                            Center(
                              child: ButtonTheme(
                                minWidth: size.width * 0.48,
                                height: size.height * 0.064,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _isValidCheck() ? Color.fromRGBO(223, 173, 78, 1) : Color.fromRGBO(106,107,108,0.4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(22.5),
                                        side: BorderSide(color: Colors.transparent)
                                    ),
                                  ),
                                  child: Text(
                                    button,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: "Open Sans",
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onPressed: _isValidCheck() ? () => _submitData(context): null,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.05,),
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
      //floatingActionButton: _floatingButton(),
    );
  }

  void _loadReservation(BuildContext context) {
    if (reservation == null) {
      final Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
      reservation = arguments?["reservation"];
      String name = reservation?.status?.name ?? "";
      final ReservationStatus reservationStatus = enumFromString(ReservationStatus.values, name.toLowerCase());
      switch (reservationStatus) {
        case ReservationStatus.approved:
          title = "Checkout Flight";
          button = "Checkout";
          hoobsLabel = "Hoobs out";
          tachLabel = "Tach out";
          _checkType = CheckType.checkout;
          _textEditingControllerTach.text = "${reservation?.aircraft?.tach}";
          _textEditingControllerHoobs.text = "${reservation?.aircraft?.hoobs}";
          break;
        case ReservationStatus.flying:
          title = "Checkin Flight";
          button = "Checkin";
          hoobsLabel = "Hoobs in";
          tachLabel = "Tach in";
          _checkType = CheckType.checkin;
          break;
        default:
          break;
      }
    }
  }

  Widget _checkImageHoobs() {
    if(_imageHoobs != null) {
      return Icon(
          Icons.check_circle,
          color: Color.fromRGBO(4, 41, 68, 1)
      );
    } else {
      return InkWell(
        child: Icon(
            Icons.add_a_photo,
            color: Color.fromRGBO(4, 41, 68, 1)
        ),
        onTap: () => _showPicker(context, CheckFileType.hoobs),
      );
    }
  }

  Widget _checkImageTach() {
    if(_imageTach != null) {
      return Icon(
          Icons.check_circle,
          color: Color.fromRGBO(4, 41, 68, 1)
      );
    } else {
      return InkWell(
        child: Icon(
            Icons.add_a_photo,
            color: Color.fromRGBO(4, 41, 68, 1)
        ),
        onTap: () => _showPicker(context, CheckFileType.tach),
      );
    }
  }

  Widget _checkImageFuel() {
    if(_imageFuel != null) {
      return Icon(
          Icons.check_circle,
          color: Color.fromRGBO(4, 41, 68, 1)
      );
    } else {
      return InkWell(
        child: Icon(
            Icons.add_a_photo,
            color: Color.fromRGBO(4, 41, 68, 1)
        ),
        onTap: () => _showPicker(context, CheckFileType.fuel),
      );
    }
  }

  Widget _getFuelWidget() {
    switch (_checkType) {
      case CheckType.checkout:
        return Container();

      case CheckType.checkin:
        return Column(
          children: [
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Fuel added (Gal.)",
                  style: GoogleFonts.openSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(106, 107, 108, 1)),
                ),
                _checkImageFuel()
              ],
            ),
            SizedBox(height: 8,),
            TextField(
                controller: _textEditingControllerFuel,
                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
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
          ],
        );

      default:
        return Container();
    }
  }

  Widget _getOilWidget() {
    switch (_checkType) {
      case CheckType.checkout:
        return Container();

      case CheckType.checkin:
        return Column(
          children: [
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Oild Added (Qt.)",
                  style: GoogleFonts.openSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(106, 107, 108, 1)),
                )
              ],
            ),
            SizedBox(height: 8,),
            TextField(
                controller: _textEditingControllerOil,
                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
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
          ],
        );

      default:
        return Container();
    }
  }

  Widget _uploadImagesWidget(Size size) {

    List<Widget> listWidgets = [
      _getHoobsPreview(size),
      SizedBox(width: 8,),
      _getTachPreview(size),
      SizedBox(width: 8,),
    ];

    if(_checkType == CheckType.checkin) {
      listWidgets.add(_getFuelPreview(size));
      listWidgets.add(SizedBox(width: 8,));
    }
    for(final item in _listDiscrepancy ) {
      listWidgets.add(_getPreviewDiscrepancy(item, size, _currentImage));
    }

    return Container(
      height: size.height * 0.0875,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: listWidgets,
      ),
    );
  }

  Widget _getPreviewDiscrepancy(PickedFile _image, Size size, int index) {
    return Row(
      children: [
        Container(
          width: size.width * 0.23,
          height: size.height * 0.0875,
          child: Stack(
              children: [
                Image.file(
                  File(_image.path),
                  width: size.width * 0.23,
                  height: size.height * 0.0875,
                  fit: BoxFit.cover,
                ),
                InkWell(
                  child: Container(
                    child: Icon(
                      Icons.remove_circle,
                      color: Colors.white,
                    ),
                    alignment: Alignment.topRight,
                  ),
                  onTap: () => _removeImage(checkFileType: CheckFileType.discrepancy, index: index),
                )
              ]
          ),
        ),
        SizedBox(width: 8,)
      ],
    );
  }

  Widget _getHoobsPreview(Size size) {
    if(_imageHoobs != null) {
      return Container(
        width: size.width * 0.23,
        height: size.height * 0.0875,
        child: Stack(
          children: [
            Image.file(
              File(_imageHoobs?.path ?? ""),
              width: size.width * 0.23,
              height: size.height * 0.0875,
              fit: BoxFit.cover,
            ),
            InkWell(
              child: Container(
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.white,
                  ),
                alignment: Alignment.topRight,
              ),
              onTap: () => _removeImage(checkFileType: CheckFileType.hoobs),
            )
          ]
        ),
      );
    } else {
      return Image(
        width: size.width * 0.23,
        height: size.height * 0.0875,
        fit: BoxFit.cover,
        image: AssetImage("assets/images/imageadd.png"),
      );
    }
  }

  Widget _getTachPreview(Size size) {
    if(_imageTach != null) {
      return Container(
        width: size.width * 0.23,
        height: size.height * 0.0875,
        child: Stack(
            children: [
              Image.file(
                File(_imageTach?.path ?? ""),
                width: size.width * 0.23,
                height: size.height * 0.0875,
                fit: BoxFit.cover,
              ),
              InkWell(
                child: Container(
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.white,
                  ),
                  alignment: Alignment.topRight,
                ),
                onTap: () => _removeImage(checkFileType: CheckFileType.tach),
              )
            ]
        ),
      );
    } else {
      return Image(
        width: size.width * 0.23,
        height: size.height * 0.0875,
        fit: BoxFit.cover,
        image: AssetImage("assets/images/imageadd.png"),
      );
    }
  }

  Widget _getFuelPreview(Size size) {
    if(_imageFuel != null) {
      return Container(
        width: size.width * 0.23,
        height: size.height * 0.0875,
        child: Stack(
            children: [
              Image.file(
                File(_imageFuel?.path ?? ""),
                width: size.width * 0.23,
                height: size.height * 0.0875,
                fit: BoxFit.cover,
              ),
              InkWell(
                child: Container(
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.white,
                  ),
                  alignment: Alignment.topRight,
                ),
                onTap: () => _removeImage(checkFileType: CheckFileType.fuel),
              )
            ]
        ),
      );
    } else {
      return Image(
        width: size.width * 0.23,
        height: size.height * 0.0875,
        fit: BoxFit.cover,
        image: AssetImage("assets/images/imageadd.png"),
      );
    }
  }

  Future _onImageButtonPressed(BuildContext context, ImageSource source, CheckFileType checkFileType) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
        imageQuality: 100,
      );

      switch (checkFileType) {
        case CheckFileType.hoobs:
          setState(() {
            _imageHoobs = pickedFile;
          });
          break;
        case CheckFileType.tach:
          setState(() {
            _imageTach = pickedFile;
          });
          break;
        case CheckFileType.fuel:
          setState(() {
            _imageFuel = pickedFile;
          });
          break;
        case CheckFileType.discrepancy:
          setState(() {
            if(pickedFile != null) {
              _currentImage += 1;
              _listDiscrepancy.add(pickedFile);
            }
          });
          break;
      }
    } catch (e) {
      showMessage(context, "Error image selected", e.toString());
    }
  }

  void _showPicker(BuildContext context, CheckFileType checkFileType) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Pick Image from gallery'),
                      onTap: () {
                        _onImageButtonPressed(context, ImageSource.gallery, checkFileType);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Take a Photo'),
                    onTap: () {
                      _onImageButtonPressed(context, ImageSource.camera, checkFileType);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  
  void _removeImage({CheckFileType? checkFileType, int? index}) {
    switch (checkFileType) {
      case CheckFileType.hoobs:
        setState(() {
          _imageHoobs = null;
        });
        break;
      case CheckFileType.tach:
        setState(() {
          _imageTach = null;
        });
        break;
      case CheckFileType.fuel:
        setState(() {
          _imageFuel = null;
        });
        break;
      case CheckFileType.discrepancy:
        setState(() {
          _currentImage -= 1;
          _listDiscrepancy.removeAt(index ?? 0 - 1);
        });
        break;
    }
  }

  bool _isValidCheck() {
    String name = reservation?.status?.name ?? "";
    final ReservationStatus reservationStatus = enumFromString(ReservationStatus.values, name.toLowerCase());
    switch (reservationStatus) {
      case ReservationStatus.approved:
        return (_imageHoobs != null)
            && (_imageTach != null)
            && (_textEditingControllerHoobs.text.isNotEmpty)
            && (_textEditingControllerTach.text.isNotEmpty)
            && _isNeedDiscrepancy();
        break;
      case ReservationStatus.flying:
        return (_imageHoobs != null)
            && (_imageTach != null)
            && (_textEditingControllerHoobs.text.isNotEmpty)
            && (_textEditingControllerTach.text.isNotEmpty)
            && (_textEditingControllerFuel.text.isNotEmpty)
            && (_textEditingControllerOil.text.isNotEmpty);
        break;
      default:
        return false;
    }
  }

  bool _isNeedDiscrepancy() {
   if ((_textEditingControllerHoobs.text.isNotEmpty)
        && (_textEditingControllerTach.text.isNotEmpty)) {
     if (reservation?.aircraft?.hoobs ==
         double.parse(_textEditingControllerHoobs.text)
         && reservation?.aircraft?.tach ==
             double.parse(_textEditingControllerTach.text)) {
       return true;
     } else {
       return (_listDiscrepancy.isNotEmpty) &&
           _textEditingControllerDiscrepancy.text.isNotEmpty;
     }
   }
   return false;
  }

  bool _showDiscrepancy() {
    if (_checkType == CheckType.checkout) {
      if ((_textEditingControllerHoobs.text.isNotEmpty)
          && (_textEditingControllerTach.text.isNotEmpty)) {
        if (reservation?.aircraft?.hoobs ==
            double.parse(_textEditingControllerHoobs.text)
            && reservation?.aircraft?.tach ==
                double.parse(_textEditingControllerTach.text)) {
          return false;
        } else {
          discrepancyDetail = "Add discrepancy is required";
          if (reservation?.aircraft?.hoobs !=
              double.parse(_textEditingControllerHoobs.text)) {
            discrepancyDetail += "\n *Hoobs discrepancy required";
          }
          if (reservation?.aircraft?.tach !=
              double.parse(_textEditingControllerTach.text)){
            discrepancyDetail += "\n *Tach discrepancy required";
          }
          return true;
        }
      }
    }
    return false;
  }

  void _submitData(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    Map<String, String> fields = {
      "hoobs": _textEditingControllerHoobs.text,
      "tach": _textEditingControllerTach.text,
    };

    List<ImageFile> files = [
      ImageFile(name: "hoobsImage", file: _imageHoobs),
      ImageFile(name: "tachImage", file: _imageTach)
    ];

    if(_checkType == CheckType.checkin) {
      fields["fuel"] = _textEditingControllerFuel.text;
      fields["oil"] = _textEditingControllerOil.text;
      files.add(ImageFile(name: "fuelImage", file: _imageFuel));
    }

    if(_textEditingControllerDiscrepancy.text.isNotEmpty) {
      fields["description"] = _textEditingControllerDiscrepancy.text;
    }
    if(_listDiscrepancy.isNotEmpty) {
      _listDiscrepancy.forEach((file) {
        files.add(ImageFile(name: "discrepancyImages", file: file));
      });
    }

    if(_checkType == CheckType.checkout) {
      _checkoutProcess(fields, files);
    } else if(_checkType == CheckType.checkin) {
      _checkinProcess(fields, files);
    }
  }

  void _checkoutProcess(Map<String, String> fields, List<ImageFile> files) async {
    final _reservationApi = ReservationApi();
    final checkoutResponse =
        await _reservationApi.checkoutReservation(reservation?.sId ?? "", fields, files);

    if(checkoutResponse != null) {
      if(checkoutResponse is CheckoutResponse) {
        final reservationResponse =
          await _reservationApi.checkoutReservationValidation(reservation?.sId ?? "");
        setState(() {
          _isLoading = false;
        });
        if(reservationResponse != null) {
          if(reservationResponse is ValidationReservation) {
            Navigator.of(context).pop(true);
          } else if(reservationResponse is String) {
            final String codeError = reservationResponse;
            showMessage(context, "Error checkout reservation", codeError);
          }
        } else {
          showMessage(context, "Error Checkout", "Error checkout reservation.");
        }
      } else if(checkoutResponse is String) {
        setState(() {
          _isLoading = false;
        });
        final String codeError = checkoutResponse;
        showMessage(context, "Error checkout reservation", codeError);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      showMessage(context, "Error Checkout", "Error checkout reservation.");
    }
  }

  void _checkinProcess(Map<String, String> fields, List<ImageFile> files) async {
    final _reservationApi = ReservationApi();
    final checkinResponse =
    await _reservationApi.checkinReservation(reservation?.sId ?? "", fields, files);

    if(checkinResponse != null) {
      if(checkinResponse is CheckinResponse) {
        final reservationResponse =
        await _reservationApi.checkinReservationValidation(reservation?.sId ?? "");

        if(reservationResponse != null) {
          if(reservationResponse is ValidationReservation) {
            generatePayment();
          } else if(reservationResponse is String) {
            setState(() {
              _isLoading = false;
            });
            final String codeError = reservationResponse;
            showMessage(context, "Error checkin reservation", codeError);
          }
        } else {
          setState(() {
            _isLoading = false;
          });
          showMessage(context, "Error Checkin", "Error checkin reservation.");
        }
      } else if(checkinResponse is String) {
        setState(() {
          _isLoading = false;
        });
        final String codeError = checkinResponse;
        showMessage(context, "Error checkin reservation", codeError);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      showMessage(context, "Error Checkin", "Error checkin reservation.");
    }
  }

  void generatePayment() async {
    final _paymentApi = PaymentApi();
    final paymentResponse =
    await _paymentApi.generatePayment(reservation?.sId ?? "");
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

  void _openNoke(BuildContext context) {
    if(reservation != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NokeView(reservation: reservation, checkSerial: true,)));
    }
  }

  Widget _floatingButton() {
    final prefs = SharedPreferencesUser();
    final Role role = enumFromString(Role.values, prefs.role);
    if(role == Role.instructor || role == Role.admin || (role == Role.pilot && prefs.flyAlone)) {
      return FloatingActionButton(
        onPressed: () => _openNoke(context),
        child: Icon(Icons.lock_open),
        backgroundColor: Color.fromRGBO(223, 173, 78, 1),
      );
    } else {
      return Container();
    }
  }
}
