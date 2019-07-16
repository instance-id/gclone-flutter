import 'package:flutter/services.dart';
import 'dart:async';

class GetDataPlugin {
  static const _channel = const MethodChannel("instance.id/go/data");
  static Future<Map> get getData async => _channel.invokeMethod("getData");
  static Future<List<String>> get getRemotes async => _channel.invokeMethod("getRemotes");

  static Future<Map> get dataGet async {
    final Map data = await _channel.invokeMethod('getData', {});
    return data;
  }

//  static Future<List<String>> get remotesGet async {
//    final List<String> data = await _channel.invokeMethod('getRemotes', {});
//    return data;
//  }

  static Future<Map> get remotesGet async {
    final Map data = await _channel.invokeMethod('getRemotes', {});
    return data;
  }
}

