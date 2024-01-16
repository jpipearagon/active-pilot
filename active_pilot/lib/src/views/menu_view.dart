import 'dart:io';

import 'package:aircraft/src/models/UserDetail.dart';
import 'package:aircraft/src/models/UserRole.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:aircraft/src/views/noke_view.dart';
import 'package:aircraft/src/views/schedule_view.dart';
import 'package:flutter/material.dart';

import 'edit_profile_view.dart';
import 'invoices_view.dart';
import 'login_view.dart';
import 'web_view.dart';

class MenuView extends StatelessWidget {

  final UserDetail userDetail;

  MenuView(this.userDetail);

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
          ),
          Positioned(
              child: new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ListTile(
                    title: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400),
                    ),
                    leading: Icon(Icons.person, color: Colors.white,),
                    minLeadingWidth : 10,
                    onTap: () {
                      Navigator.of(context).pop();
                      _logout(context);
                    },
                  )
              )
          )
        ],
      ),
    );
  }

  List<Widget> _menus(BuildContext context) {

    List<MenuItem> menu = [
      MenuItem(1, 'My Profile', Icons.perm_contact_cal_rounded),
      MenuItem(2, 'My Schedule', Icons.calendar_today),
      MenuItem(3, 'My Invoices', Icons.payments)
    ];

    final prefs = SharedPreferencesUser();
    final Role role = enumFromString(Role.values, prefs.role);
    switch (role) {
      case Role.admin:
      case Role.instructor:
        //menu.add(MenuItem(4, 'Unlock Noke', Icons.lock_open));
        menu.add(MenuItem(4, 'User License Agreement', Icons.assignment_outlined));
        break;
      case Role.pilot:
      case Role.student:
      case Role.registered:
        menu.add(MenuItem(4, 'User License Agreement', Icons.assignment_outlined));
        break;
    }

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
        leading: Icon(menuItem.icon, color: Colors.white,),
        minLeadingWidth : 10,
        onTap: () {
          Navigator.of(context).pop();
          final prefs = SharedPreferencesUser();
          final Role role = enumFromString(Role.values, prefs.role);

          switch (menuItem.tag) {
            case 1:
              _openProfile(context);
              break;
            case 2:
              _openSchedule(context);
              break;
            case 3:
              _openInvoices(context);
              break;
            case 4:
              /*if(role == Role.pilot || role == Role.student || role == Role.registered) {
                _openLegal(context);
              } else {
                _openNoke(context);
              }*/
              _openLegal(context);
              break;
            case 5:
              _openLegal(context);
              break;
          }
        },
      );
    }).toList();
  }

  void _openProfile(BuildContext context) {
    Navigator.of(context).pushNamed(EditProfileView.routeName, arguments: {"userDetail": userDetail});
  }

  void _openSchedule(BuildContext context) {
    Navigator.of(context).pushNamed(ScheduleView.routeName);
  }

  void _openNoke(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NokeView(reservation: null, checkSerial: false,)));
  }

  void _openLegal(BuildContext context) {
    if (Platform.isIOS) {
      Navigator.of(context).pushNamed(OpenWebView.routeName, arguments: {"title": "User License Agreement", "url": "https://s3.amazonaws.com/assets.activepilot/public/userLicenseAgreement.pdf"});
    } else {
      Navigator.of(context).pushNamed(OpenWebView.routeName, arguments: {"title": "User License Agreement", "url": "https://docs.google.com/gview?embedded=true&url=https://s3.amazonaws.com/assets.activepilot/public/userLicenseAgreement.pdf"});
    }
  }

  void _openInvoices(BuildContext context) {
    Navigator.of(context).pushNamed(InvoicesView.routeName);
  }

  void _logout(BuildContext context) {
    final prefs = SharedPreferencesUser();
    prefs.userLogged = false;
    Navigator.of(context).pushReplacementNamed(LoginView.routeName);
  }
}



class MenuItem {
  int tag;
  String title;
  IconData icon;

  MenuItem(this.tag, this.title, this.icon);
}
