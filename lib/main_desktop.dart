import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gclone/models/stepper/stepper_settings.dart';
import 'package:gclone/provider/theme_data.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'app_home.dart';
import 'models/get_data.dart';
import 'models/pointer_status.dart';
// The client and host sides of a channel are connected through
// a channel name passed in the channel constructor.

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  debugPaintPointersEnabled = false;
  GetDataPlugin pData = GetDataPlugin();
  pData.init();

  runApp(
    gclone(pData),
  );
}

// ignore: camel_case_types
class gclone extends StatelessWidget {
  final GetDataPlugin data;
  final StepperSetting stepperSettings = StepperSetting();

  gclone(this.data);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GetDataPlugin>.value(value: data),
        ChangeNotifierProvider<PointerStatus>.value(value: PointerStatus()),
        ChangeNotifierProvider<StepperSetting>.value(value: stepperSettings),
        // ChangeNotifierProvider<StatsLineChart>.value(value: StatsLineChart()),
      ],
      child: MaterialApp(
        showPerformanceOverlay: false,
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        title: 'gclone',
        home: AppHome(),

//        ChangeNotifierProvider<GetDataPlugin>(
//          builder: (context) => GetDataPlugin(),
//          child: AppHome(),
//        ),
        theme: themeData,
      ),
    );
  }
}
