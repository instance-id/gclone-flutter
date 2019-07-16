import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './app_meta.dart' as my_app_meta;


// The client and host sides of a channel are connected through
// a channel name passed in the channel constructor.

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
