import 'package:flutter/material.dart';
import 'package:gclone/routes/home_drawer.dart';
import 'package:gclone/routes/job_status.dart';
import 'package:gclone/routes/provider_list.dart';
import 'package:gclone/routes/remotes.dart';
import 'package:gclone/routes/schedule_jobs.dart';
import 'package:gclone/routes/tab_menu.dart';
import 'package:provider/provider.dart';

import 'helpers/animate_route.dart';
import 'helpers/custom_color.dart';
import 'models/get_data.dart';

//List remotes;
//Map getData;
//List providerData;
//List<CardDetails> remotesList;

class AppHome extends StatefulWidget {
  AppHome(this.getDataPlugin);
  final GetDataPlugin getDataPlugin;

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
    final GetDataPlugin getDataPlugin = Provider.of<GetDataPlugin>(context);

    TabMenu navigator = TabMenu(
      key: _keyNavigator,
      onChanged: onChanged,
    );

    return Scaffold(
      appBar: bar(),
      drawer: Drawer(
        child: HomeDrawer(),
        //child: getNavDrawerItems(this, context),
      ),
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

  AppBar bar() {
    return AppBar(
      title: Text(
        'Gclone',
        style:
            TextStyle(color: Color(0xFF2ead51), letterSpacing: 1, fontSize: 30),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Color(0xFF2ead51),
      ),
      actions: <Widget>[
        PopupMenuButton<int>(
          onSelected: (int result) async {
            switch (result) {
              case 0:
                Navigator.push(
                  context,
                  AnimateRoute(
                    fullscreenDialog: true,
                    builder: (context) => ProviderList(),
                  ),
                );
                break;

              case 1:
//                var bloc = BlocProvider(
//                  bloc: TaskBloc(),
//                  child: TaskEditor(task: Task()),
//                );
//
//                Navigator.push(
//                  context,
//                  AnimateRoute(builder: (context) => bloc),
//                );
                break;

              case 2:
//                var bloc = BlocProvider(
//                  bloc: ProductBloc(),
//                  child: ProductEditor(
//                    product: Product(),
//                  ),
//                );
//
//                Navigator.push(
//                  context,
//                  AnimateRoute(builder: (context) => bloc),
//                );
                break;

              case 3:
                // await SharedUtil.syncronized(context);
                break;
            }
          },
          icon: Icon(Icons.add),
          tooltip: "Provider Menu",
          itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
            const PopupMenuItem<int>(
              value: 0,
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(
                  Icons.clear_all,
                  color: AppColors.PRIMARY_DARK,
                ),
                title: Text(
                  'Add New Provider',
                  style: TextStyle(
                    color: AppColors.PRIMARY_DARK,
                  ),
                ),
              ),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(
                  Icons.fitness_center,
                  color: AppColors.PRIMARY_DARK,
                ),
                title: Text(
                  'Tarefas',
                  style: TextStyle(
                    color: AppColors.PRIMARY_DARK,
                  ),
                ),
              ),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(
                  Icons.shopping_cart,
                  color: AppColors.PRIMARY_DARK,
                ),
                title: Text(
                  'Produtos',
                  style: TextStyle(
                    color: AppColors.PRIMARY_DARK,
                  ),
                ),
              ),
            ),
            /*
                const PopupMenuItem<int>(
                  value: 3,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(
                      Icons.sync,
                      color: AppColors.PRIMARY_DARK,
                    ),
                    title: Text(
                      'Sincronizar',
                      style: TextStyle(
                        color: AppColors.PRIMARY_DARK,
                      ),
                    ),
                  ),
                ),
                */
          ],
        ),
      ],
    );
  }
}
