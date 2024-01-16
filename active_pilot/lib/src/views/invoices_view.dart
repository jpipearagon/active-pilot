import 'package:aircraft/src/constants/application_colors.dart';
import 'package:aircraft/src/models/Reservation.dart';
import 'package:aircraft/src/noke/NokeManager.dart';
import 'package:aircraft/src/views/check_flight_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'header_view.dart';
import 'invoice_list_view.dart';
import 'invoices_readytopay_view.dart';


class InvoicesView extends StatefulWidget {

  static final routeName = "invoicesView";

  @override
  _InvoicesView createState() => _InvoicesView();
}

class _InvoicesView extends State<InvoicesView> {

  final _pageController = PageController();
  int _currentMenu = 0;

  @override
  Widget build(BuildContext context) {
    return _app(context);
  }

  Widget _app(BuildContext context) {

    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: Column(
        children: [
          HeaderView(title: "My Invoices", subtitle: ""),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(4, 41, 68, 1)
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: 0,
                    left: 30.0,
                    right: 30.0
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    )),
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      _menus(),
                      Container(
                        width: double.infinity,
                        height: 1,
                        decoration:
                        BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.11)),
                      ),
                      Expanded(
                        child: _pages(),
                      )
                    ],
                  ),
                  ),
                ),

              ),
            ),
        ],
      ),
    );
  }

  Widget _menus() {
    return Container(
      width: double.infinity,
      height: 53,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _listMenus(),
      ),
    );
  }

  List<Widget> _listMenus() {
    final menus = ["Ready to pay", "Invoices"];
    final List<Widget> listMenus = [];
    menus.asMap().forEach((idx, val) {
      TextStyle style;
      Container container;
      if (idx == _currentMenu) {
        style = TextStyle(
            color: Color.fromRGBO(223, 173, 78, 1),
            fontSize: 14,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600);
        container = Container(
          height: 1,
          decoration: BoxDecoration(color: Color.fromRGBO(223, 173, 78, 1)),
        );
      } else {
        style = TextStyle(
            color: Color.fromRGBO(106, 107, 108, 1),
            fontSize: 14,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w400);
        container = Container();
      }

      final menu = Expanded(
        child: TextButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(
                val,
                style: style,
                textScaleFactor: 1.0,
              ),
              container
            ],
          ),
          onPressed: () {
            setState(() {
              _currentMenu = idx;
              _pageController.animateToPage(_currentMenu,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            });
          },
        ),
      );
      listMenus.add(menu);
    });
    return listMenus;
  }

  Widget _pages() {
    return PageView.builder(
        itemCount: 2,
        controller: _pageController,
        onPageChanged: (index) {
          _pageChanged(index);
        },
        itemBuilder: (context, index) {
          if (index == 0) {
            return InvoiceReadyToPayView(
              key: Key("readytopay"),
            );
          }
          if (index == 1) {
            return InvoiceListView(
              key: Key("invoice"),
            );
          }
          return Container();
        });
  }

  void _pageChanged(int index) {
    setState(() {
      _currentMenu = index;
    });
  }
}
