import 'package:flutter/material.dart';

class ApplicationColors {
  static ApplicationColors _singleton;

  Color primaryColor;
  Color backArrow;

  factory ApplicationColors() {
    if (_singleton == null) {
      _singleton = ApplicationColors._();
    }

    _singleton.primaryColor = const Color(0xFF042944);
    _singleton.backArrow = const Color(0xFFDFAD4E);

    return _singleton;
  }

  ApplicationColors._();
}
