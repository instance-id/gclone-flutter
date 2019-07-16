import 'package:flutter/services.dart';
import 'dart:async';

class GetVersionPlugin {
  static const _channel = const MethodChannel("instance.id/go/version");
  static Future<String> get version async => _channel.invokeMethod("getVersion");

  static Future<String> get versionGet async {
    final String vers = await _channel.invokeMethod('getVersion', {});
    return vers;
  }
}

