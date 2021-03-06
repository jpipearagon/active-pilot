import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showMessage(BuildContext context, String title, String message) {
  if (Platform.isIOS) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ));
  } else if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }
}