import 'package:aircraft/src/views/schedule_view.dart';
import 'package:flutter/material.dart';

class ConfirmationView extends StatefulWidget {

  static final routeName = "confirmation";

  @override
  _ConfirmationViewState createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView> {

  bool _checkOne = false;
  bool _checkTwo = false;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        title:  Transform(
          // you can forcefully translate values left side using Transform
          transform:  Matrix4.translationValues(14.0, 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Confirmation",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 30,
                      fontWeight: FontWeight.w600 ,
                      color: Colors.white// semi-bold
                  )
              ),
              Text(
                  "Please sign in to continue.",
                  style: TextStyle(
                      fontFamily: "Open Sans",
                      fontSize: 14,
                      fontWeight: FontWeight.w400 ,
                      color: Colors.white// semi-bold
                  )
              )
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(4, 41, 68, 1),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 10),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromRGBO(4, 41, 68, 1)
          ),
          child: Container(
            padding: EdgeInsets.only(top: 42, left: 46, right: 46),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                )
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "Example title",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 20,
                          fontWeight: FontWeight.w700 ,
                          color: Color.fromRGBO(4,41,68,1)// semi-bold
                      )
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Volutpat amet, nunc, non faucibus leo ultricies amet, gravida consequat. Sed sem lobortis orci, pretium volutpat. Felis feugiat vitae risus diam magna ac massa. Ultrices nulla neque lobortis cras non nisi, nisi. Pharetra, varius sit cursus vel pharetra mollis amet pretium egestas. Ornare a odio arcu at. Sit condimentum vitae eu rutrum vivamus dui at justo. Lectus mi, ut elementum, scelerisque ultrices arcu elementum ultricies.",
                      style: TextStyle(
                          fontFamily: "Open Sans",
                          fontSize: 12,
                          fontWeight: FontWeight.w400 ,
                          color: Color.fromRGBO(0,0,0,1)// semi-bold
                      )
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Color.fromRGBO(223,173,78,1)),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        "Company policy - Acknowledgment",
                        style: TextStyle(
                            color: Color.fromRGBO(0,0,0,1),
                            fontSize: 14,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w600),),
                      value: _checkOne,
                      activeColor: Color.fromRGBO(4,41,68,1),
                      checkColor: Color.fromRGBO(223,173,78,1),
                      onChanged: (value) {
                        setState(() {
                          _checkOne = value;
                        });
                      },
                    ),
                  ),
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Color.fromRGBO(223,173,78,1)),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        "FAA 91-103 - Acknowledgment",
                        style: TextStyle(
                            color: Color.fromRGBO(0,0,0,1),
                            fontSize: 14,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w600),),
                      value: _checkTwo,
                      activeColor: Color.fromRGBO(4,41,68,1),
                      checkColor: Color.fromRGBO(223,173,78,1),
                      onChanged: (value) {
                        setState(() {
                          _checkTwo = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: ButtonTheme(
                      minWidth: size.width * 0.48,
                      height: size.height * 0.064,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.5),
                            side: BorderSide(color: Colors.transparent)
                        ),
                        color: (_checkOne && _checkTwo) ? Color.fromRGBO(223, 173, 78, 1) : Color.fromRGBO(106,107,108,0.4),
                        child: Text(
                          "Accept",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: "Open Sans",
                              fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          Navigator.of(context).popUntil(ModalRoute.withName(ScheduleView.routeName));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
