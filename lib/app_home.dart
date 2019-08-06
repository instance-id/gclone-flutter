import 'package:flutter/material.dart';
import 'package:gclone/routes/about.dart';
import 'package:gclone/routes/app_bar.dart';
import 'package:gclone/routes/job_status.dart';
import 'package:gclone/routes/provider_list.dart';
import 'package:gclone/routes/remotes.dart';
import 'package:gclone/routes/schedule_jobs.dart';
import 'package:gclone/routes/tab_menu.dart';

//List remotes;
//Map getData;
//List providerData;
//List<CardDetails> remotesList;

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with TickerProviderStateMixin {
  final GlobalKey<TabMenuState> _keyNavigator = GlobalKey<TabMenuState>();

  get getDataPlugin => null;

  @override
  void initState() {
    super.initState();
  }

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
    pages.add(ProviderList());
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
      primary: true,
      appBar: DraggebleAppBar(
        appBar: MainAppBar(context, _keyNavigator, pageController),
      ),
      body: Scaffold(
        drawer: Drawer(
          child: AboutRoute(context),
        ),
        body: Stack(
          children: <Widget>[
            PageView(
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
            Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(canvasColor: Colors.transparent),
                  child: navigator,
                ))
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
