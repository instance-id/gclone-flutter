import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class GetDataPlugin with ChangeNotifier {
  static const _channel = const MethodChannel("instance.id/go/data");

//  static Future<List<String>> get remotesGet async {
//    final List<String> data = await _channel.invokeMethod('getRemotes', {});
//    return data;
//  }
//
//  Future<List<dynamic>> getRemotes2() async {
//    remotes = await _channel.invokeMethod('getRemotes', {});
//    notifyListeners();
//    return remotes;
//  }

  Future<List<dynamic>> getRemotes() async {
    return await _channel.invokeMethod('getRemotes', {});
  }

  Future<Map<dynamic, dynamic>> getData() async {
    return await _channel.invokeMethod('getData', {});
  }
}
//
//class GetProviderData with ChangeNotifier {
//  getRemotes2() {}
//  final List<String> tmp = notifyListeners();
//}

//  static Future<Map> get getData async => _channel.invokeMethod("getData");
//  static Future<List<String>> get getRemotes async =>
//      _channel.invokeMethod("getRemotes");

//  static Future<Map> get dataGet async {
//    final Map data = await _channel.invokeMethod('getData', {});
//    return data;
//  }

//  static Future<List<dynamic>> get remotesGet async {
//    final List<dynamic> data = await _channel.invokeMethod('getRemotes', {});
//    return data;
//  }
