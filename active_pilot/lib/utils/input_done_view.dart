import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InputDoneView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(40, 55, 66, 1),
      width: double.infinity,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: CupertinoButton(
            padding: EdgeInsets.only(right: 24, top: 8,bottom: 8),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Text(
              "Done",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }
}
