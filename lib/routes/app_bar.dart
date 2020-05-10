import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gclone_flutter/helpers/animate_route.dart';
import 'package:gclone_flutter/helpers/custom_color.dart';
import 'package:gclone_flutter/routes/provider_add.dart';
import 'package:gclone_flutter/routes/tab_menu.dart';

class MainAppBar extends StatelessWidget {
  MainAppBar(BuildContext context, this.keyNavigator, this._pageController);
  final GlobalKey<TabMenuState> keyNavigator;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
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
                // keyNavigator.currentState.move(3, hideMenu: true);
                // _pageController.jumpToPage(3);
                Navigator.push(
                  context,
                  AnimateRoute(
                    fullscreenDialog: true,
                    builder: (context) => ProviderAdd(), // ProviderList(),
                  ),
                );
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
                    color: AppColors.LIGHTER_TEXT,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DraggebleAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const platform_channel_dragable =
      MethodChannel('samples.go-flutter.dev/dragable');

  final MainAppBar appBar;
  const DraggebleAppBar({Key key, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: appBar, onPanStart: onPanStart, onPanEnd: onPanEnd);
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);

  void onPanStart(DragStartDetails details) async {
    await platform_channel_dragable.invokeMethod('onPanStart',
        {"dx": details.globalPosition.dx, "dy": details.globalPosition.dy});
  }

  void onPanEnd(DragEndDetails details) async {
    await platform_channel_dragable.invokeMethod('onPanEnd');
  }
}
