import 'dart:async';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:flutter/material.dart';
import 'login_view.dart';
import 'profile_view.dart';

class SplashView extends StatefulWidget {

  static final routeName = "splash";

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), initSplash);
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(17, 34, 48, 1)
        ),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
            children: [
              Center(
                child: Image(
                  width: size.width * 0.6825,
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
              Positioned(
                  child: new Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Image(
                        width: size.width,
                        image: AssetImage("assets/images/logoBottom.png"),
                      )
                  )
              )
            ]
        ),
      ),
    );
  }

  void initSplash() {
    final prefs = SharedPreferencesUser();
    if(prefs.userLogged) {
      Navigator.of(context).pushReplacementNamed(ProfileView.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(LoginView.routeName);
    }
  }
}
