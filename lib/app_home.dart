import 'package:flutter/material.dart';
import 'package:gclone/provider/navigation_provider.dart';
import 'package:gclone/routes/tab_menu.dart';
import 'package:provider/provider.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
//      drawer: Drawer(
//        child: my_app_data.getNavDrawerItems(this, context),
//      ),
      body: Consumer<NavigationProvider>(
          builder: (context, navigationProvider, _) =>
              navigationProvider.getNavigation),
      bottomNavigationBar: TabMenu(),
    );
  }
}
