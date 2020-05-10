import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gclone_flutter/provider/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:gclone_flutter/provider/theme_data.dart';


import 'app_home.dart';

// The client and host sides of a channel are connected through
// a channel name passed in the channel constructor.

void main() {
  runApp(
    MaterialApp(
      title: 'gclone',
      theme: themeData,
      // No need to set `home` because `routes` is set to a routing table, and
      // Navigator.defaultRouteName ('/') has an entry in it.
      home: ChangeNotifierProvider<NavigationProvider>(
        create: (context) =>NavigationProvider(),
        child: AppHome(),
      ),
    ),
  );
}
