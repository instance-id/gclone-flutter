import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './app_meta.dart' as my_app_meta;

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(
    MaterialApp(
      title: 'gclone',
      theme: ThemeData(primarySwatch: Colors.blue),
      // No need to set `home` because `routes` is set to a routing table, and
      // Navigator.defaultRouteName ('/') has an entry in it.
      routes: my_app_meta.kRoutingTable,
    ),
  );
}
