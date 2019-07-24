import 'package:flutter/material.dart';
import 'package:gclone/routes/about.dart';

import 'models/app_data.dart';

Widget getNavDrawerItems(State state, BuildContext context) {
  final drawerHeader = DrawerHeader(
    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        AppIcon,
        Text(APP_NAME, style: Theme.of(context).textTheme.title),
        Text('$APP_VERSION', style: Theme.of(context).textTheme.caption),
      ],
    ),
  );

  List<Widget> drawerNavItems = []..add(drawerHeader)..add(AboutRoute(context));
  return ListView(
    children: drawerNavItems,
    shrinkWrap: true,
  );
}
