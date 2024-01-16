import 'package:aircraft/src/bloc/profile_bloc.dart';
import 'package:aircraft/src/bloc/user_bloc.dart';
import 'package:aircraft/src/models/UserDetail.dart';
import 'package:aircraft/src/models/UserTotals.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:aircraft/src/views/edit_profile_view.dart';
import 'package:aircraft/src/views/logbook_view.dart';
import 'package:aircraft/src/views/menu_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import 'document_profile_view.dart';
import 'endorsment_view.dart';

class ProfileView extends StatefulWidget {
  static final routeName = "profile";

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _profileBloc = ProfileBloc();
  final _pageController = PageController();
  final _userBloc = UserBloc();
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
    _userBloc.loadTotals();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        color: Colors.white,
        opacity: 1.0,
        progressIndicator: Lottie.asset('assets/gifs/35718-loader.json',
            width: 100, height: 100),
        isLoading: _isLoading,
        child: _resolveProfile(context));
  }

  Widget _resolveProfile(BuildContext context) {
    return StreamBuilder(
        stream: _profileBloc.streamProfile,
        builder: (BuildContext context, AsyncSnapshot<UserDetail> snapshot) {
          if (snapshot.hasData) {
            UserDetail? userDetail = snapshot.data;
            return _app(context, userDetail!);
          }
          return Container();
        });
  }

  Widget _app(BuildContext context, UserDetail userDetail) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(4, 41, 68, 1),
          leading: new Container()),
      endDrawer: Drawer(child: MenuView(userDetail)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color.fromRGBO(4, 41, 68, 1)),
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
                _profileWidget(userDetail),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                      )),
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
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileWidget(UserDetail userDetail) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.3,
      child: Container(
        height: size.height * 0.20,
        padding: EdgeInsets.only(
            top: size.height * 0.02,
            left: 24,
            right: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _profileView(userDetail),
        ),
      ),
    );
  }

  List<Widget> _profileView(UserDetail? userDetail) {
    final prefs = SharedPreferencesUser();
    prefs.role = userDetail?.roleStr ?? "";
    final size = MediaQuery.of(context).size;

    final listWidget = [
      Container(

        width: 120,
        height: 120,
        child: _imageProfile(userDetail, size)
      ),
      Expanded(
          child: SizedBox()
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 110),
                child: AutoSizeText(
                  "${userDetail?.firstName} ${userDetail?.lastName}",
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 16,
                  maxLines: 2,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white // semi-bold
                      ),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                child: Icon(
                  Icons.edit,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  size: 20,
                ),
                onTap: () => _openProfile(context, userDetail),
              )
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "${userDetail?.roleStr?.toUpperCase()}",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(223, 173, 78, 1)),
          ),
          SizedBox(
            height: 20,
          ),
          _loadTotals()
        ],
      )
    ];

    return listWidget;
  }

  Widget _loadTotals() {
    return StreamBuilder<UserTotals>(
      stream: _userBloc.userTotalStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      AutoSizeText(
                        _formatDouble(snapshot.data?.totalDays),
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 16,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white // semi-bold
                        ),
                      ),
                      Text(
                        "Total Hours",
                        style: TextStyle(
                            fontFamily: "Open Sans",
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(196, 196, 196, 1)),
                      ),
                      AutoSizeText(
                        "${snapshot.data?.last90Days}",
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 16,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white // semi-bold
                        ),
                      ),
                      Text(
                        "Last 90 days",
                        style: TextStyle(
                            fontFamily: "Open Sans",
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(196, 196, 196, 1)),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  Column(
                    children: [
                      AutoSizeText(
                        "${snapshot.data?.last30Days}",
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 16,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white // semi-bold
                        ),
                      ),
                      Text(
                        "Last 30 days",
                        style: TextStyle(
                            fontFamily: "Open Sans",
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(196, 196, 196, 1)),
                      ),
                      Column(
                        children: [
                          AutoSizeText(
                            "${snapshot.data?.approaches}",
                            overflow: TextOverflow.ellipsis,
                            minFontSize: 16,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white // semi-bold
                            ),
                          ),
                          Text(
                            "IFR Approaches",
                            style: TextStyle(
                                fontFamily: "Open Sans",
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(196, 196, 196, 1)),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Container();
        }
        return Container();
      },
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
    final menus = ["Logbook", "Docs"];
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
            return LogBookView(
              key: Key("logbook"),
            );
          }
          /*if (index == 1) {
            return EndorsmentView(
              key: Key("endorsment"),
            );
          }*/
          if (index == 1) {
            return DocumentProfileView(
              key: Key("documentprofile"),
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

  void _openProfile(BuildContext context, UserDetail? userDetail) async {
    final result = await Navigator.of(context).pushNamed(EditProfileView.routeName, arguments: {"userDetail": userDetail});
    if(result != null && result as bool && result) {
      _reloadData();
    }
  }

  Widget _imageProfile(UserDetail? userDetail, Size size) {
      Widget image;
      if(userDetail?.photo?.url != null) {
        image = Image.network(userDetail?.photo?.url ?? "", fit: BoxFit.fill);
      } else {
        image = Image.asset("assets/images/defaultprofile.png");
      }

      return CircleAvatar(
        radius: size.width * 1,
        backgroundColor: Colors.transparent,
        child:  ClipRRect(
          borderRadius: new BorderRadius.circular(60),
          child: AspectRatio(
              aspectRatio: 1,
              child: image),
        ),
      );
  }

  String _formatDouble(double? value) {
    if (value != null) {
      var verbose = value.toStringAsFixed(4);
      var trimmed = verbose;
      //trim all trailing 0's after the decimal point (and the decimal point if applicable)
      for (var i = verbose.length - 1; i > 0; i--) {
        if (trimmed[i] != '0' && trimmed[i] != '.' || !trimmed.contains('.')) {
          break;
        }
        trimmed = trimmed.substring(0, i);
      }
      return trimmed;
    } else {
      return "0";
    }

  }
}
