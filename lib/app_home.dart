import 'package:flutter/material.dart';
import 'package:gclone/routes/job_status.dart';
import 'package:gclone/routes/remotes.dart';
import 'package:gclone/routes/schedule_jobs.dart';
import 'package:gclone/routes/tab_menu.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with TickerProviderStateMixin {
  final GlobalKey<TabMenuState> _keyNavigator = GlobalKey<TabMenuState>();

  final List<Widget> pages = [];
  int pageIx = 1;
  final PageController pageController = PageController(
    initialPage: 1,
  );
  bool _propagateAnimations = true;

  _AppHomeState() {
    pages.add(ScheduleJobs());
    pages.add(Remotes());
    pages.add(JobStatus());
  }

  void onChanged(int idx) {
    _propagateAnimations = false;
    pageController.animateToPage(
      idx,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    TabMenu navigator = TabMenu(
      key: _keyNavigator,
      onChanged: onChanged,
    );

    return Scaffold(
      appBar: AppBar(),
//      drawer: Drawer(
//        child: my_app_data.getNavDrawerItems(this, context),
//      ),
      body: PageView(
        onPageChanged: (i) {
          setState(() => pageIx = i);
          if (_propagateAnimations == true) {
            _keyNavigator.currentState.move(i);
          }
          _propagateAnimations = true;
        },
        controller: pageController,
        children: pages,
        physics: BouncingScrollPhysics(),
      ),
      bottomNavigationBar: navigator,
    );
  }
}
