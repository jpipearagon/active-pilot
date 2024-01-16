import 'package:flutter/material.dart';

class ApplicationColors {
  ApplicationColors._internal();
  static ApplicationColors _singleton = ApplicationColors._internal();

  Color primaryColor = const Color(0xFF042944);
  Color backArrow = const Color(0xFFDFAD4E);
  factory ApplicationColors() {
    return _singleton;
  }
}
