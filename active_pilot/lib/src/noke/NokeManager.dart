
import 'dart:collection';

import 'package:flutter/services.dart';

class NokeManager {

  static const platform = const MethodChannel('com.activepilot.aircraft/noke');

  Future<LinkedHashMap<dynamic, dynamic>> initNoke(String serial, bool checkSerial) async {
    try {
      final dynamic result = await platform.invokeMethod('initNoke', {"serial": serial, "checkSerial": checkSerial});
      return result as LinkedHashMap<dynamic, dynamic>;
    } on PlatformException catch (e) {
      LinkedHashMap mapB = LinkedHashMap();
      mapB["status"] = "Failed to get noke: '${e.message}'.";
      return mapB;
    }
  }

  Future<LinkedHashMap<dynamic, dynamic>> unlockNoke(String serial, bool checkSerial) async {
    try {
      final dynamic result = await platform.invokeMethod('unlockNoke', {"serial": serial, "checkSerial": checkSerial});
      return result;
    } on PlatformException catch (e) {
      LinkedHashMap mapB = LinkedHashMap();
      mapB["status"] = "Failed to get noke: '${e.message}'.";
      return mapB;
    }
  }

}