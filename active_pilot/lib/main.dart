import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:aircraft/src/views/confirmation_view.dart';
import 'package:aircraft/src/views/schedule_view.dart';
import 'package:aircraft/src/views/login_view.dart';
import 'package:aircraft/src/views/noke_view.dart';
import 'package:aircraft/src/views/profile_view.dart';
import 'package:aircraft/src/views/register_view.dart';
import 'package:aircraft/src/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/views/reservation_view.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  final prefs = SharedPreferencesUser();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Active Pilot',
        initialRoute: SplashView.routeName,
        routes: {
          SplashView.routeName: (context) => SplashView(),
          LoginView.routeName: (context) => LoginView(),
          ProfileView.routeName: (context) => ProfileView(),
          ScheduleView.routeName: (context) => ScheduleView(),
          ReservationView.routeName: (context) => ReservationView(),
          ConfirmationView.routeName: (context) => ConfirmationView(),
          RegisterView.routeName: (context) => RegisterView(),
          NokeView.routeName: (context) => NokeView(),
        }
    );
  }
}
