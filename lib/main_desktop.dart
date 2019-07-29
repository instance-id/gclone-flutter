import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gclone/provider/navigation_provider.dart';
import 'package:gclone/provider/theme_data.dart';
import 'package:provider/provider.dart';

import 'app_home.dart';
import 'models/get_data.dart';
import 'models/provider_data.dart';
// The client and host sides of a channel are connected through
// a channel name passed in the channel constructor.

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(
    gclone(),
  );
}

// ignore: camel_case_types
class gclone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    GetDataPlugin getDataPlugin = GetDataPlugin();
    ProviderData providerData = ProviderData();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getDataPlugin),
        ChangeNotifierProvider.value(value: providerData),
      ],
      child: MaterialApp(
        showPerformanceOverlay: false,
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        title: 'gclone',
        home: ChangeNotifierProvider<NavigationProvider>(
          builder: (context) => NavigationProvider(getDataPlugin),
          child: AppHome(getDataPlugin),
        ),
        theme: themeData,
      ),
    );
  }
}
