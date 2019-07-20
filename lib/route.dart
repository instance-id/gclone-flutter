import 'package:flutter/material.dart';
import 'package:gclone/routes/job_status.dart';
import 'package:gclone/routes/schedule_jobs.dart';
import 'package:gclone/routes/tab_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import './app_meta.dart' as my_app_meta;

//abstract class AppRoutes extends StatefulWidget {
//  // Path of source file (relative to project root). The file's content will be
//  // shown in the "Code" tab.
//  final String _sourceFile;
//
//  static of(BuildContext context) =>
//      context.rootAncestorStateOfType(const TypeMatcher<_AppRoutesState>());
//
//  const AppRoutes(this._sourceFile);
//
//  // Subclasses can return routeName accordingly (polymorphism).
//  String get routeName => '/${this.runtimeType.toString()}';
//
//  // Title shown in the route's appbar and in the app's navigation drawer item.
//  // By default just returns routeName.
//  String get title => this.routeName;
//
//  // A short description of the route. If not null, will be shown as subtitle in
//  // app's navigation drawer.
//  String get description => null;
//
//  // Returns a set of links {title:link} that are relative to the route. Can put
//  // documention links or reference video/article links here.
//  Map<String, String> get links => {};
//
//  // Returns the widget that will be shown in the "Preview" tab.
//  Widget buildMyRouteContent(BuildContext context);
//
//  @override
//  State<StatefulWidget> createState() => _AppRoutesState();
//}
//
//// Each MyRoute contains two tabs: "Preview" and "Code".
//// --- Main Tabs ------------------------------------------------------------------------------------------------------
//var _tabs = <Widget>[TabMenu()];
//
//final makeBottom = Container(
//  height: 55.0,
//  child: BottomAppBar(
//    color: Color.fromRGBO(33, 33, 33, 1.0),
//    child: Row(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      children: <Widget>[
//        IconButton(
//          icon: Icon(Icons.home, color: Colors.white),
//          onPressed: () {},
//        ),
//        IconButton(
//          icon: Icon(Icons.blur_on, color: Colors.white),
//          onPressed: () {},
//        ),
//        IconButton(
//          icon: Icon(Icons.hotel, color: Colors.white),
//          onPressed: () {},
//        ),
//        IconButton(
//          icon: Icon(Icons.account_box, color: Colors.white),
//          onPressed: () {},
//        )
//      ],
//    ),
//  ),
//);
//
//class _AppRoutesState extends State<AppRoutes>
//    with SingleTickerProviderStateMixin {
//  TabController _tabController;
//  SharedPreferences _preferences;
//
//  @override
//  void initState() {
//    super.initState();
//    _tabController = TabController(length: _tabs.length, vsync: this);
//    my_app_meta.kSharedPreferences
//      ..then((prefs) => setState(() => this._preferences = prefs));
//  }
//
//  @override
//  void dispose() {
//    _tabController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      // --- Tab Contents ---------------------------------------------------------------------------------------------
//      body: Builder(builder: (BuildContext context) {
//        final myTabPages = <Widget>[
//          // "Menu Tabs" tab:
//          AlwaysAliveWidget(child: this.widget.buildMyRouteContent(context)),
//          AlwaysAliveWidget(child: ScheduleJobs()),
//          AlwaysAliveWidget(child: JobStatus()),
//        ];
//        assert(myTabPages.length == _tabs.length);
//        // Body of MyRoute is two-tabs ("Preview" and "Code").
//        return TabBarView(
//          children: myTabPages,
//          controller: this._tabController,
//        );
//      }),
//      bottomNavigationBar: TabBar(
//        tabs: _tabs,
//        controller: this._tabController,
//      ),
//      // Only home route has drawer:
//      drawer: this.widget.routeName == Navigator.defaultRouteName
//          ? Drawer(
//              child: my_app_meta.getNavDrawerItems(this, context),
//            )
//          : null,
//    );
//  }
//
//  // Returns a widget showing the star status of one demo route: a star icon
//  // with counts.



