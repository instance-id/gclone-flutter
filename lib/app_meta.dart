// This file declares "metadata" (or "structure") of the app, in a const
// List<Tuple2> object. And it provides functions to get app's routing table or
// app's navigation drawer menu items from the declared metadata.
import 'package:flutter/material.dart';
import 'package:gclone/routes/home_2.dart';
import 'package:gclone/routes/remotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './route.dart';
import './routes/about.dart';
import './routes/home.dart';
import './routes/sub_tabs.dart';
import './routes/version_route.dart';


// Metadatas about this app:
// *Note*: when APP_VERSION is changed, remember to also update pubspec.yaml.
const APP_VERSION = 'v0.0.1';
const APP_NAME = 'gclone';
final kAppIcon =
Image.asset('res/images/launcher_icon.png', height: 64.0, width: 64.0);
const APP_DESCRIPTION = 'A Rclone multiplatform GUI '
    '\n\nDeveloped by instance.id.';
const GOOGLEPLAY_URL =
    'https://play.google.com/store/apps/details?id=io.github.x_wei.flutter_catalog';
const GITHUB_URL = 'https://github.com/instance-id/gclone_flutter';
const AUTHOR_SITE = 'http://instance.id';

const kHomeRoute = HomeRoute2();
//const kHomeRoute = Remotes();
const kAboutRoute = AboutRoute();

// All routes should use this same preference instance, to avoid unexpected
// states-not-updated issues.
final Future<SharedPreferences> kSharedPreferences =
SharedPreferences.getInstance();

// A class to manage the bookmark status of routes.
class BookmarkManager {
  static const kBookmarkedRoutesPreferenceKey = 'BOOKMARKED_ROUTES';

  // Returns if a route is stared or not.
  static bool isStared(String routeName, SharedPreferences preferences) {
    return bookmarkedRoutenames(preferences).contains(routeName) ?? false;
  }

  // Toggles the local stared/not-stared status of a route.
  static void toggleStared(String routeName, SharedPreferences preferences) {
    final staredRoutes = bookmarkedRoutenames(preferences);
    if (isStared(routeName, preferences)) {
      staredRoutes.remove(routeName);
    } else {
      staredRoutes.add(routeName);
    }
    final dedupedStaredRoutes = Set<String>.from(staredRoutes).toList();
    preferences?.setStringList(
        kBookmarkedRoutesPreferenceKey, dedupedStaredRoutes);
  }

  static List<String> bookmarkedRoutenames(SharedPreferences preferences) {
    return preferences?.getStringList(kBookmarkedRoutesPreferenceKey) ?? [];
  }

  static Future<List<String>> bookmarkedRoutenamesAsync() async {
    final preferences = await kSharedPreferences;
    return bookmarkedRoutenames(preferences);
  }
}

// The structure of app's navigation drawer items is a 2-level menu, its schema
// is the following:
// [ MyRouteGroup{
//        groupName: group1_name,
//        icon: group1_icon,
//        routes: [route1, route2, ...]
//   },
//   MyRouteGroup{
//        groupName: group2_name,
//        icon: group2_icon,
//        routes: [route1, route2, ...]
//   },
//   ...
// ]
class MyRouteGroup {
  const MyRouteGroup(
      {@required this.groupName, @required this.icon, @required this.routes});
  final String groupName;
  final Widget icon;
  final List<MyRoute> routes;
}

// --- Routes on page -------------------------------------------------------------------------------------------------
const kMyAppRoutesStructure = <MyRouteGroup>[
  MyRouteGroup(
    groupName: 'Tabs',
    icon: Icon(Icons.cloud),
    routes: <MyRoute>[
      TabsExample(),
      DisplayVersion()
    ],
  ),
];

final _allRoutes = kMyAppRoutesStructure.expand((group) => group.routes);

// Mapping route names to routes.
final kRoutenameToRouteMap = Map<String, MyRoute>.fromIterable(
  _allRoutes,
  key: (route) => route.routeName,
  value: (route) => route,
)..addAll(
  {
    // By default go to home screen. (Navigator.defaultRouteName is just '/')
    Navigator.defaultRouteName: kHomeRoute,
    kAboutRoute.routeName: kAboutRoute,
  },
);

// The app's root-level routing table.
Map<String, WidgetBuilder> kRoutingTable = kRoutenameToRouteMap.map(
      (routeName, route) {
    final widgetBuilder = (BuildContext context) => route;
    return MapEntry<String, WidgetBuilder>(routeName, widgetBuilder);
  },
);

// Returns the app's navigation drawer menu items.
ListView getNavDrawerItems(State state, BuildContext context) {
  final drawerHeader = DrawerHeader(
    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        kAppIcon,
        Text(APP_NAME, style: Theme.of(context).textTheme.title),
        Text('$APP_VERSION', style: Theme.of(context).textTheme.caption),
      ],
    ),
  );

  List<Widget> drawerNavItems = []
    ..add(drawerHeader)
    ..addAll(kAboutRoute.aboutListTiles(context));
  return ListView(
    children: drawerNavItems,
  );
}
