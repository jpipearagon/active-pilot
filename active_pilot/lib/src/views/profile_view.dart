import 'package:aircraft/src/apis/user_detail_api.dart';
import 'package:aircraft/src/bloc/profile_bloc.dart';
import 'package:aircraft/src/models/UserDetail.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:aircraft/src/views/logbook_view.dart';
import 'package:aircraft/src/views/menu_view.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import 'edit_profile_view.dart';
import 'endorsment_view.dart';


class ProfileView extends StatefulWidget {

  static final routeName = "profile";

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final _profileBloc = ProfileBloc();
  final _pageController = PageController();
  int _currentMenu = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reloadData();
    });
  }

  void _reloadData() async {
    setState(() {
      _isLoading = true;
    });
    await _profileBloc.loadProfile();
    setState(() {
      _isLoading = false;
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

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(4, 41, 68, 1),
          leading: new Container()
      ),
      endDrawer: Drawer(
        child: MenuView()
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromRGBO(4, 41, 68, 1)
        ),
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.15,
              child: Align(
                alignment: Alignment.topLeft,
                child: Image(
                  image: AssetImage("assets/images/brand.png"),
                ),
              ),
            ),
            Column(
              children: [
                _profileWidget(),
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0),
                          )
                      ),
                      child: Column(
                        children: <Widget>[
                          _menus(),
                          Container(
                            width: double.infinity,
                            height: 1,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0,0,0,0.11)
                            ),
                          ),
                          Expanded(
                            child: _pages(),
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileWidget() {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: _profileBloc.streamProfile,
        builder: (BuildContext context, AsyncSnapshot<UserDetail> snapshot)
        {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              height: size.height * 0.3,
              child: Container(
                height: size.height * 0.20,
                padding: EdgeInsets.only(top: size.height*0.02, left: size.height*0.067, right: size.height*0.067),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _profileView(snapshot.data),
                ),
              ),
            );
          }
          return Container();
        }
    );
  }

  List<Widget> _profileView(UserDetail userDetail) {
    final size = MediaQuery.of(context).size;

    final listWidget = [
      CircleAvatar(
        radius: size.width * 0.1,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage("assets/images/defaultprofile.png"),
      ),
      SizedBox(width: 22,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${userDetail.firstName} ${userDetail.lastName}",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.w600 ,
                color: Colors.white// semi-bold
            ),
          ),
          SizedBox(height: 4,),
          Text("${userDetail.role.toUpperCase()}",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 11,
                fontWeight: FontWeight.w500 ,
                color: Color.fromRGBO(223, 173, 78, 1)
            ),
          ),
          SizedBox(height: 24,),
          Row(
            children: [
              Column(
                children: [
                  Text("0",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.w600 ,
                        color: Colors.white// semi-bold
                    ),
                  ),
                  Text("Total Hours",
                    style: TextStyle(
                        fontFamily: "Open Sans",
                        fontSize: 11,
                        fontWeight: FontWeight.w400 ,
                        color: Color.fromRGBO(196,196,196,1)
                    ),
                  )
                ],
              ),
              SizedBox(width: 35,),
              Column(
                children: [
                  Text("0",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.w600 ,
                        color: Colors.white// semi-bold
                    ),
                  ),
                  Text("Last 30 days",
                    style: TextStyle(
                        fontFamily: "Open Sans",
                        fontSize: 11,
                        fontWeight: FontWeight.w400 ,
                        color: Color.fromRGBO(196,196,196,1)
                    ),
                  )
                ],
              )
            ],
          )
        ],
      )
    ];

    return listWidget;
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
    final menus = ["Logbook", "Endorsment", "Profile"];
    final listMenus = List<Widget>();
    menus.asMap().forEach((idx, val) {

      TextStyle style;
      Container container;
      if(idx == _currentMenu) {
        style = TextStyle(
            color: Color.fromRGBO(223,173,78,1),
            fontSize: 14,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600);
        container = Container(
          height: 1,
          decoration: BoxDecoration(
              color: Color.fromRGBO(223,173,78,1)
          ),
        );
      } else {
        style = TextStyle(
            color: Color.fromRGBO(106,107,108,1),
            fontSize: 14,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w400);
        container = Container();
      }


      final menu = Expanded(
        child: FlatButton(
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
        itemCount: 3,
        controller: _pageController,
        onPageChanged: (index) {
          _pageChanged(index);
        },
        itemBuilder: (context, index) {
          if (index == 0) {
            return LogBookView(
              key: Key("logbook"),
            );
          }
          if (index == 1) {
            return EndorsmentView(
              key: Key("endorsment"),
            );
          }
          if (index == 2) {
            return EditProfileView(
              key: Key("editprofile"),
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
