import 'package:flutter/material.dart';
import './app_meta.dart' as app_meta;

void main() => runApp(
  MaterialApp(
    title: 'gclone',
    theme: ThemeData(primarySwatch: Colors.blue),
    // No need to set `home` because `routes` is set to a routing table, and
    // Navigator.defaultRouteName ('/') has an entry in it.
    routes: app_meta.kRoutingTable,
  ),
);
