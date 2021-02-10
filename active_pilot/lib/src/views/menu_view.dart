import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:aircraft/src/views/profile_view.dart';
import 'package:aircraft/src/views/schedule_view.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';

class MenuView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromRGBO(4,41,68,1)
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 80),
            child: ListView(
              children: _menus(context),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _menus(BuildContext context) {
    return menu.map((menuItem) {
      return ListTile(
        title: Text(
          menuItem.title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w400),
        ),
        onTap: () {
          Navigator.of(context).pop();
          switch (menuItem.tag) {
            case 1:
              _openSchedule(context);
              break;
            case 2:
              break;
            case 3:
              _logout(context);
              break;
          }
        },
      );
    }).toList();
  }

  void _openSchedule(BuildContext context) {
    Navigator.of(context).pushNamed(ScheduleView.routeName);
  }

  void _logout(BuildContext context) {
    final prefs = SharedPreferencesUser();
    prefs.userLogged = false;
    Navigator.of(context).pushReplacementNamed(LoginView.routeName);
  }
}

final List<MenuItem> menu = [
  MenuItem(1, 'MY SCHEDULE'),
  MenuItem(2, 'PAYMENT METHODS'),
  MenuItem(3, 'LOGOUT'),
];

class MenuItem {
  int tag;
  String title;

  MenuItem(this.tag, this.title);
}
