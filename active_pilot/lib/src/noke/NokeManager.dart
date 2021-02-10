
import 'package:flutter/services.dart';

class NokeManager {

  static const platform = const MethodChannel('com.activepilot.aircraft/noke');

  Future<String> initNoke() async {
    try {
      final String result = await platform.invokeMethod('initNoke');
      return result;
    } on PlatformException catch (e) {
      return "Failed to get noke: '${e.message}'.";
    }
  }

  Future<String> unlockNoke() async {
    try {
      final String result = await platform.invokeMethod('unlockNoke');
      return result;
    } on PlatformException catch (e) {
      return "Failed to get noke: '${e.message}'.";
    }
  }

}