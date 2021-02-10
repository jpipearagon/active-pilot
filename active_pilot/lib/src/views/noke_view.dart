import 'package:aircraft/src/noke/NokeManager.dart';
import 'package:flutter/material.dart';


class NokeView extends StatefulWidget {

  static final routeName = "nokeView";

  @override
  _NokeViewState createState() => _NokeViewState();
}

class _NokeViewState extends State<NokeView> {

  final NokeManager _nokeManager = NokeManager();
  String _status = "No lock connected";
  String _buttonText = "Disabled";

  @override
  void initState() {
    super.initState();
    //_started();
  }

  @override
  Widget build(BuildContext context) {
    return _app(context);
    /*return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status),
            RaisedButton(
              color: Color.fromRGBO(66, 66, 66, 0.82),
              child: Text(
                _buttonText,
              ),
              onPressed: () async {
                String result = await _nokeManager.unlockNoke();
                setState(() {
                  _status = result;
                });
              },
            )
          ],
        ),
      ),
    );*/
  }

  Widget _app(BuildContext context) {

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
                  "Smart Lock",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 30,
                      fontWeight: FontWeight.w600 ,
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
            padding: EdgeInsets.only(top: 42, left: 36, right: 36),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                )
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                ],
              ),
            ),
          )
      ),
    );
  }

  Future<Null> _started() async {
    String result = await _nokeManager.initNoke();
    setState(() {
      _status = result;
      _buttonText = "Unlock";
    });
    return null;
  }

}
