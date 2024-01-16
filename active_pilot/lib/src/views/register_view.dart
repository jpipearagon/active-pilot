import 'dart:convert';

import 'package:aircraft/src/apis/locations_api.dart';
import 'package:aircraft/src/apis/register_user_api.dart';
import 'package:aircraft/src/models/Locations.dart';
import 'package:aircraft/src/models/RegisterUser.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:aircraft/src/views/message_dialog_view.dart';
import 'package:aircraft/src/views/profile_view.dart';
import 'package:aircraft/src/views/select_data_view.dart';
import 'package:aircraft/src/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class RegisterView extends StatefulWidget {

  static final routeName = "register";

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {


  final TextEditingController _textEditingControllerLicenceID =
  new TextEditingController();
  final TextEditingController _textEditingControllerEmail =
  new TextEditingController();
  final TextEditingController _textEditingControllerDate =
  new TextEditingController();
  final TextEditingController _textEditingControllerFirst =
  new TextEditingController();
  final TextEditingController _textEditingControllerLast =
  new TextEditingController();
  final TextEditingController _textEditingControllerGender =
  new TextEditingController();
  final TextEditingController _textEditingControllerPass =
  new TextEditingController();
  final TextEditingController _textEditingControllerConfirmPass =
  new TextEditingController();
  final TextEditingController _textEditingControllerPhone =
  new TextEditingController();


  String PickerData = '''
[
    [
        "Female",
        "Male"
    ]
]
    ''';

  bool _isLoading = false;
  LocationUser? _locationUser;
  String _strLocation = "Select Location";

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
      body: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(4, 42, 68, 1)
        ),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: Image(
                  width: double.infinity,
                  image: AssetImage("assets/images/marktop.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 60, left: 50, right: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage("assets/images/logomini.png"),
                  ),
                  Text(
                    "Register",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 30,
                        fontWeight: FontWeight.w700 ,
                        color: Colors.white// semi-bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Please sign in to continue.",
                    style: TextStyle(
                        fontFamily: "Open Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400 ,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: size.height * 0.037,),
                  firstNameTextField(),
                  SizedBox(height: size.height * 0.037,),
                  lastNameTextField(),
                  SizedBox(height: size.height * 0.037,),
                  emailTextField(),
                  SizedBox(height: size.height * 0.037,),
                  phoneTextField(),
                  SizedBox(height: size.height * 0.037,),
                  locationWidget(),
                  SizedBox(height: size.height * 0.037,),
                  passwordTextField(),
                  SizedBox(height: size.height * 0.037,),
                  confirmPasswordTextField(),
                  SizedBox(height: size.height * 0.037,),
                  Center(
                    child: ButtonTheme(
                      minWidth: 170.0,
                      height: 36.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(223, 173, 78, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.transparent)
                          ),
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: "Open Sans",
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () => _registerUser(context),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05,),
                  Container(
                    child: Row(
                      children: [
                        Text("You have an account?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w300)),
                        SizedBox(width: 10,),
                        GestureDetector(
                          child: Text("Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700)),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.076,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingControllerLicenceID.dispose();
    _textEditingControllerEmail.dispose();
    _textEditingControllerDate.dispose();
    _textEditingControllerFirst.dispose();
    _textEditingControllerLast.dispose();
    _textEditingControllerGender.dispose();
    _textEditingControllerPass.dispose();
    _textEditingControllerConfirmPass.dispose();
    _textEditingControllerPhone.dispose();
    super.dispose();
  }

  Widget licenceTextField() {
    return Container(
      child: TextField(
        autocorrect: false,
        controller: _textEditingControllerLicenceID,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "Licence ID",
            hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image(
                width: 16,
                height: 16,
                image: AssetImage("assets/images/profile.png"),
              ),
            )
        ),
        onChanged: (text) {

        },
      ),
    );
  }

  Widget emailTextField() {
    return Container(
      child: TextField(
        autocorrect: false,
        controller: _textEditingControllerEmail,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "Email",
            hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                  width: 15,
                  height: 20,
                  child: Icon(Icons.email, color: Color.fromRGBO(223, 173, 78, 1))
              ),
            )
        ),
        onChanged: (text) {

        },
      ),
    );
  }

  Widget dateTextField() {
    return Container(
      child: TextField(
        readOnly: true,
        controller: _textEditingControllerDate,
        keyboardType: TextInputType.datetime,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "Date of birthday",
            hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image(
                width: 16,
                height: 15,
                image: AssetImage("assets/images/calendar.png"),
              ),
            )
        ),
        onTap: () => _selectDate(context),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      DateFormat _dateFormat = DateFormat("yyyy-MM-dd");
      _textEditingControllerDate.text = _dateFormat.format(pickedDate);
    }
  }

  Widget firstNameTextField() {
    return Container(
      child: TextField(
        autocorrect: false,
        controller: _textEditingControllerFirst,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "First Name",
            hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                  width: 15,
                  height: 17,
                  child: Icon(Icons.person, color: Color.fromRGBO(223, 173, 78, 1))
              ),
            )
        ),
        onChanged: (text) {

        },
      ),
    );
  }

  Widget lastNameTextField() {
    return Container(
      child: TextField(
        autocorrect: false,
        controller: _textEditingControllerLast,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "Last Name",
            hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                  width: 15,
                  height: 17,
                  child: Icon(Icons.person, color: Color.fromRGBO(223, 173, 78, 1))
              )
            )
        ),
        onChanged: (text) {

        },
      ),
    );
  }

  Widget genderTextField() {
    return Container(
      child: TextField(
        autocorrect: false,
        controller: _textEditingControllerGender,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        readOnly: true,
        decoration: InputDecoration(
            hintText: "Gender",
            hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(width: 17, height: 15,),
            )
        ),
        onTap: (){
          new Picker(
              adapter: PickerDataAdapter<String>(pickerdata: new JsonDecoder().convert(PickerData), isArray: true),
              changeToFirst: true,
              hideHeader: false,
              onConfirm: (Picker picker, List value) {
                _textEditingControllerGender.text = picker.adapter.text.replaceAll("[", "").replaceAll("]", "");
              }
          ).showModal(context);
        },
      ),
    );
  }

  Widget passwordTextField() {
    return Container(
      child: TextField(
        autocorrect: false,
        controller: _textEditingControllerPass,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        obscureText: true,
        decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                  width: 17,
                  height: 20,
                  child: Icon(Icons.remove_red_eye, color: Color.fromRGBO(223, 173, 78, 1))
              ),
            )
        ),
      ),
    );
  }

  Widget confirmPasswordTextField() {
    return Container(
      child: TextField(
        autocorrect: false,
        controller: _textEditingControllerConfirmPass,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        obscureText: true,
        decoration: InputDecoration(
            hintText: "Confirm Password",
            hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                  width: 17,
                  height: 20,
                  child: Icon(Icons.remove_red_eye, color: Color.fromRGBO(223, 173, 78, 1))
              ),
            )
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return Container(
      child: TextField(
        autocorrect: false,
        controller: _textEditingControllerPhone,
        keyboardType: TextInputType.phone,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "Phone",
            hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                  width: 17,
                  height: 20,
                  child: Icon(Icons.phone, color: Color.fromRGBO(223, 173, 78, 1))
              ),
            )
        ),
      ),
    );
  }

  Widget locationWidget() {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color.fromRGBO(223, 173, 78, 1),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                        _strLocation,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400
                        )
                    ),
                  ),
                  SizedBox(
                      width: 12,
                      height: 19,
                      child: Icon(Icons.arrow_forward_ios, color: Color.fromRGBO(223, 173, 78, 1))
                  )
                ],
              ),
            ),
            onTap: () => _getLocation(),
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
                color: Color.fromRGBO(238, 238, 238, 1)
            ),
          ),
        ],
      ),
    );
  }

  void _getLocation() async {
    setState(() {
      _isLoading = true;
    });
    final locationApi = LocationsApi();
    final locations = await locationApi.getLocations();
    setState(() {
      _isLoading = false;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SelectDataView(type: Types.location,
              data: locations ?? [],
              onTap: (type, data) => _selectData(type, data),),
          );
        });
  }

  void _selectData(Types type, dynamic dataSelect) {
    if(type == Types.location) {
      _locationUser = dataSelect;
      setState(() {
        _strLocation = _locationUser?.name ?? "";
      });
    }
  }

  void _registerUser(BuildContext context) async {
    String email = _textEditingControllerEmail.text;
    String first = _textEditingControllerFirst.text;
    String last = _textEditingControllerLast.text;
    String phone = _textEditingControllerPhone.text;
    String pass = _textEditingControllerPass.text;
    String confpass = _textEditingControllerConfirmPass.text;


    if(email.isEmpty || first.isEmpty || last.isEmpty || pass.isEmpty || confpass.isEmpty || phone.isEmpty || _locationUser == null) {
      showMessage(context, "Error Register", "The fields must not be empty") ;
      return;
    }

    if(confpass != pass) {
      showMessage(context, "Error Register", "The password is different from the confirmation") ;
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final _registerUserApi = RegisterUserApi();
    final statusLogin =
    await _registerUserApi.registerUser(first, last, pass, email, phone, _locationUser?.id ?? "");

    if(statusLogin != null) {

      if(statusLogin is RegisterUser) {
        setState(() {
          _isLoading = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: MessageView(
                    title: "SUCCESS",
                    message: "Your registration is complete, now you can log in with ${statusLogin.email}",
                    onTap: () => successRegistered(context)),
              );
            });
      } else if(statusLogin is String) {
        final String codeError = statusLogin;
        setState(() {
          _isLoading = false;
        });
        showMessage(context, "Error Register", codeError);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      showMessage(context, "Error Register", "User registration service error.");
    }
  }

  void successRegistered(BuildContext context) {
    Navigator.pop(context);
  }

}

