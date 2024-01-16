import 'dart:io';

import 'package:aircraft/src/apis/locations_api.dart';
import 'package:aircraft/src/apis/user_detail_api.dart';
import 'package:aircraft/src/constants/application_colors.dart';
import 'package:aircraft/src/models/ImageFile.dart';
import 'package:aircraft/src/models/ProfileCountry.dart';
import 'package:aircraft/src/models/UserDetail.dart';
import 'package:aircraft/src/models/UserRole.dart';
import 'package:aircraft/src/views/select_data_view.dart';
import 'package:aircraft/src/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'header_view.dart';

class EditProfileView extends StatefulWidget {

  static final routeName = "edit_profile_view";

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {

  final TextEditingController _textEditingControllerFirst = TextEditingController();
  final TextEditingController _textEditingControllerLast = TextEditingController();
  final TextEditingController _textEditingControllerEmail = TextEditingController();
  final TextEditingController _textEditingControllerPhone = TextEditingController();
  final TextEditingController _textEditingControllerDate = TextEditingController();
  final TextEditingController _textEditingControllerGiV = TextEditingController();
  final TextEditingController _textEditingControllerFiv = TextEditingController();
  final TextEditingController _textEditingControllerCity = TextEditingController();
  final TextEditingController _textEditingControllerAddress = TextEditingController();
  final TextEditingController _textEditingControllerAddress2 = TextEditingController();
  final TextEditingController _textEditingControllerState = TextEditingController();
  final TextEditingController _textEditingControllerZip = TextEditingController();

  bool _isLoading = false;
  UserDetail? _userDetail;
  String _strCountry = "Select Country";
  ProfileCountry? _profileCountry;
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageProfile;
  String? _dateBirth;

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
    UserDetail userDetail = arguments?["userDetail"];
    _loadUserDetail(userDetail);

    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: [
            HeaderView(title: "Edit Profile", subtitle: ""),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Stack(
                                children: [
                                  _checkImageProfile(context, size, userDetail),
                                  Positioned(
                                      bottom: 0,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: ApplicationColors().primaryColor,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                          color: ApplicationColors().primaryColor
                                        ),
                                      child: Icon(Icons.add, color: Colors.white,),
                                    )
                                  )
                                ],
                              ),
                              onTap: () => _showPicker(context),
                            ),
                            SizedBox(height: size.height * 0.037,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "First Name",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(4,41,68,1)),
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  controller: _textEditingControllerFirst,
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
                              ],
                            ),
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last Name",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(4,41,68,1)),
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  controller: _textEditingControllerLast,
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
                              ],
                            ),
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(4,41,68,1)),
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  enabled: false,
                                  controller: _textEditingControllerEmail,
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
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(4,41,68,1)),
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  controller: _textEditingControllerPhone,
                                  keyboardType: TextInputType.phone,
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
                              ],
                            ),
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Birthday",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(4,41,68,1)),
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  readOnly: true,
                                  controller: _textEditingControllerDate,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1.0),
                                    ),
                                    hintText: '',
                                  ),
                                  onTap: () => _selectDate(context),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Country",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(4,41,68,1)),
                                ),
                                SizedBox(height: 10,),
                                InkWell(
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Color.fromRGBO(238, 238, 238, 1))
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 12,),
                                        Expanded(
                                          child: Text(
                                              _strCountry,
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
                                  onTap: () => _showData(Types.country),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "City",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(4,41,68,1)),
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  controller: _textEditingControllerCity,
                                  keyboardType: TextInputType.streetAddress,
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
                              ],
                            ),
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(4,41,68,1)),
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  controller: _textEditingControllerAddress,
                                  keyboardType: TextInputType.streetAddress,
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
                                TextField(
                                  controller: _textEditingControllerAddress2,
                                  keyboardType: TextInputType.streetAddress,
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
                              ],
                            ),
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "State",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(4,41,68,1)),
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  controller: _textEditingControllerState,
                                  keyboardType: TextInputType.streetAddress,
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
                              ],
                            ),
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Zipcode",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(4,41,68,1)),
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  controller: _textEditingControllerZip,
                                  keyboardType: TextInputType.streetAddress,
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
                              ],
                            ),
                            _instructorFields(userDetail, size),
                            SizedBox(height: size.height * 0.037,),
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
                                    _updateUserDetail(userDetail);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.037,),
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

  void _loadUserDetail(UserDetail userDetail) {
    if(_userDetail == null) {
      _userDetail = userDetail;
      _textEditingControllerFirst.text = userDetail.firstName ?? "";
      _textEditingControllerLast.text = userDetail.lastName ?? "";
      _textEditingControllerEmail.text = userDetail.email ?? "";
      _textEditingControllerPhone.text = userDetail.phone ?? "";
      _textEditingControllerCity.text = userDetail.city ?? "";
      _textEditingControllerAddress.text = userDetail.address ?? "";
      _textEditingControllerAddress2.text = userDetail.address2 ?? "";
      _textEditingControllerState.text = userDetail.state ?? "";
      _textEditingControllerZip.text = userDetail.zip ?? "";
      _dateBirth = userDetail.dateBirth;

      if(_dateBirth != null) {
        DateTime dateBirth = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse("${userDetail.dateBirth}");
        DateFormat _dateFormat = DateFormat.yMMMMd('en_US');
        _textEditingControllerDate.text = _dateFormat.format(dateBirth);
      }

      if(userDetail.country != null) {
        _profileCountry = ProfileCountry(deleted: userDetail.country?.deleted, sId: userDetail.country?.id, name: userDetail.country?.name);
        _strCountry = userDetail.country?.name ?? "";
      }
      final Role role = enumFromString(Role.values, userDetail.roleStr ?? "");
      if(role == Role.instructor || role == Role.admin) {
        _textEditingControllerGiV.text = userDetail.instructor?.giv ?? "";
        _textEditingControllerFiv.text = userDetail.instructor?.fiv ?? "";
      }
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      DateFormat _dateFormat = DateFormat.yMMMMd('en_US');
      _textEditingControllerDate.text = _dateFormat.format(pickedDate);
      DateFormat _dateFormat1 = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
      _dateBirth = _dateFormat1.format(pickedDate);
    }
  }

  void _showData(Types type) async {

    if(type == Types.country) {
      _showLoading();
      final locationApi = LocationsApi();
      final locations = await locationApi.getCountries();
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SelectDataView(type: type,
                data: locations ?? [],
                onTap: (type, data) => _selectData(type, data),),
            );
          });
    }

  }

  void _selectData(Types type, dynamic dataSelect) {
    if(type == Types.country) {
      _profileCountry = dataSelect;
      setState(() {
        _strCountry = _profileCountry?.name ?? "";
      });
    }
  }

  void _showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  Widget _checkImageProfile(BuildContext context, Size size, UserDetail userDetail) {

    if(_imageProfile != null) {
      return ClipOval(
        child: Image.file(
          File(_imageProfile?.path ?? ""),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
      );
    } else {
      Widget image;
      if(userDetail.photo != null) {
        image = Image.network(userDetail.photo?.url ?? "", fit: BoxFit.fill);
      } else {
        image = Image.asset("assets/images/defaultprofile.png");
      }
      return CircleAvatar(
        radius: size.width * 0.15,
        backgroundColor: Colors.transparent,
        child:  ClipRRect(
          borderRadius: new BorderRadius.circular(100.0),
          child: AspectRatio(
              aspectRatio: 4 / 4,
              child: image),
        ),
      );
    }
  }

  void _showPicker(BuildContext context) {
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
                        _onImageButtonPressed(context, ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Take a Photo'),
                    onTap: () {
                      _onImageButtonPressed(context, ImageSource.camera);
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

  Future _onImageButtonPressed(BuildContext context, ImageSource source) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
        imageQuality: 100,
      );

      setState(() {
        _imageProfile = pickedFile;
      });
    } catch (e) {
      showMessage(context, "Error image selected", e.toString());
    }
  }

  Widget _instructorFields(UserDetail userDetail, Size size) {
    final Role role = enumFromString(Role.values, userDetail?.roleStr ?? "");
    if(role == Role.instructor || role == Role.admin) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height*0.023,),
          Container(
            height: 1,
            decoration: BoxDecoration(
                color: Color.fromRGBO(106,107,108,1)
            ),
          ),
          SizedBox(height: 10,),
          Text(
            'Ground Instruction Rate',
            style: GoogleFonts.openSans(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(4,41,68,1)),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: _textEditingControllerGiV,
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
            'Flight Instruction Rate',
            style: GoogleFonts.openSans(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(4,41,68,1)),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: _textEditingControllerFiv,
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
        ],
      );
    } else {
      return Container();
    }
  }

  void _updateUserDetail(UserDetail userDetail) async {

    setState(() {
      _isLoading = true;
    });

    Map<String, String> fields = {
      "firstName": _textEditingControllerFirst.text,
      "lastName": _textEditingControllerLast.text,
      "phone": _textEditingControllerPhone.text,
      "dateBirth": _textEditingControllerDate.text,
      "city": _textEditingControllerCity.text,
      "address": _textEditingControllerAddress.text,
      "address2": _textEditingControllerAddress2.text,
      "state": _textEditingControllerState.text,
      "zip": _textEditingControllerZip.text,
      "country._id": _profileCountry?.sId ?? ""
    };

    List<ImageFile> files = [ ];

    if(_imageProfile != null) {
      files.add(ImageFile(name: "photo", file: _imageProfile),);
    }

    final _reservationApi = UserDetailApi();

    final Role role = enumFromString(Role.values, userDetail.roleStr ?? "");
    if(role == Role.instructor || role == Role.admin) {
      Map<String, String> fieldsInstructor = {
        "giv": _textEditingControllerGiV.text,
        "fiv": _textEditingControllerFiv.text,
      };
      final updateResponse =
      await _reservationApi.updateInstructor(userDetail.id ?? "", fieldsInstructor);
    }

    final updateResponse =
        await _reservationApi.updateUser(userDetail.id ?? "", fields, files);

    if(updateResponse != null) {
      if(updateResponse is UserDetail) {
        setState(() {
          _isLoading = false;
        });
        await futureShowMessage(context, "Successful update", "It was updated correctly.");
        Navigator.of(context).pop(true);
      } else if(updateResponse is String) {
        setState(() {
          _isLoading = false;
        });
        final String codeError = updateResponse;
        showMessage(context, "Error update profile", codeError);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      showMessage(context, "Error update profile", "Error checkin reservation.");
    }
  }
}

