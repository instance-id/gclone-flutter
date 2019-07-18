import 'package:flutter/material.dart';
import './app_meta.dart' as app_meta;

void main() => runApp(
  MaterialApp(
    title: 'gclone',
    theme: ThemeData( brightness: Brightness.dark,
      primaryColor: Colors.lightBlue[800],
      accentColor: Colors.cyan[600],

      // Define the default font family.
      fontFamily: 'Montserrat',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    ),
    // No need to set `home` because `routes` is set to a routing table, and
    // Navigator.defaultRouteName ('/') has an entry in it.
    routes: app_meta.kRoutingTable,

  ),
);
