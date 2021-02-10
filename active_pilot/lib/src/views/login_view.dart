import 'package:aircraft/src/apis/login_user_api.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:aircraft/src/views/profile_view.dart';
import 'package:aircraft/src/views/register_view.dart';
import 'package:aircraft/src/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import 'schedule_view.dart';

class LoginView extends StatefulWidget {

  static final routeName = "login";

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final TextEditingController _textEditingControllerEmail =
  new TextEditingController();
  final TextEditingController _textEditingControllerPassword =
  new TextEditingController();
  bool _isLoading = false;

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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(4, 42, 68, 1)
          ),
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage("assets/images/brand.png"),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 46),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 30,
                            fontWeight: FontWeight.w700 ,
                            color: Colors.white// semi-bold
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 46, top: 10),
                      child: Text(
                        "Please sign in to continue.",
                        style: TextStyle(
                            fontFamily: "Open Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w400 ,
                            color: Colors.white// semi-bold
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.1296,),
                    emailTextField(),
                    SizedBox(height: size.height * 0.073,),
                    passwordTextField(),
                    SizedBox(height: size.height * 0.093,),
                    Center(
                      child: ButtonTheme(
                        minWidth: 154.0,
                        height: 36.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.transparent)
                          ),
                          color: Color.fromRGBO(223, 173, 78, 1),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () {
                            _login(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.084,),
                    Container(
                      padding: EdgeInsets.only(left: 51),
                      child: Row(
                        children: [
                          Text("Don’t have an account?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w300)),
                          SizedBox(width: 10,),
                          GestureDetector(
                            child: Text("Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w700)),
                            onTap: () {
                              Navigator.of(context).pushNamed(RegisterView.routeName);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Container(
      padding: EdgeInsets.only(left: 51, right: 51),
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
                fontWeight: FontWeight.w600),
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
                image: AssetImage("assets/images/emailicon.png"),
              ),
            )
        ),
        onChanged: (text) {

        },
      ),
    );
  }

  Widget passwordTextField() {
    return Container(
      padding: EdgeInsets.only(left: 51, right: 51),
      child: TextField(
        autocorrect: false,
        controller: _textEditingControllerPassword,
        obscureText: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600),
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
                image: AssetImage("assets/images/passicon.png"),
              ),
            )
        ),
        onChanged: (text) {

        },
      ),
    );
  }

  void _login(BuildContext context) async {
    String email = _textEditingControllerEmail.text;
    String password = _textEditingControllerPassword.text;

    if(email.isEmpty) {
      showMessage(context, "Error Login", "Please enter an email") ;
      return;
    }

    if(password.isEmpty) {
      showMessage(context, "Error Login", "Please enter a password") ;
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final _loginUserApi = LoginUserApi();
    final statusLogin =
        await _loginUserApi.loginUser(email, password);

    if(statusLogin != null) {
      final prefs = SharedPreferencesUser();
      prefs.userLogged = true;
      prefs.userId = statusLogin.user.id;
      prefs.jwtToken = statusLogin.jwtToken;
      prefs.refreshToken = statusLogin.refreshToken;
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed(ProfileView.routeName);
    } else {
      setState(() {
        _isLoading = false;
      });
      showMessage(context, "Error Login", "Email or password are wrong.");
    }

  }
}
