import 'package:flutter/material.dart';
import 'package:gclone_flutter/models/app_data.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

// Inspired by the about page in Eajy's flutter demo:
// https://github.com/Eajy/flutter_demo/blob/master/lib/route/about.dart
class AboutRoute extends StatelessWidget {
  AboutRoute(BuildContext context);

  get title => 'About';

  // These tiles are also used as drawer nav items in home route.
  List<Widget> aboutListTiles(BuildContext context) {
    return <Widget>[
      ListTile(
        title: Text(APP_DESCRIPTION),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.shop),
        title: Text('Rate on Google Play'),
        onTap: () => url_launcher.launch(GOOGLEPLAY_URL),
      ),
      ListTile(
        leading: Icon(Icons.code),
        title: Text('Source code on GitHub'),
        onTap: () => url_launcher.launch(GITHUB_URL),
      ),
      ListTile(
        leading: Icon(Icons.bug_report),
        title: Text('Report issue on GitHub'),
        onTap: () => url_launcher.launch('$GITHUB_URL/issues'),
      ),
      ListTile(
        leading: Icon(Icons.open_in_new),
        title: Text('Visit my website'),
        onTap: () => url_launcher.launch(AUTHOR_SITE),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final header = ListTile(
      leading: AppIcon,
      title: Text(APP_NAME),
      subtitle: Text(APP_VERSION),
      trailing: IconButton(
        icon: Icon(Icons.info),
        onPressed: () {
          showAboutDialog(
              context: context,
              applicationName: APP_NAME,
              applicationVersion: APP_VERSION,
              applicationIcon: AppIcon,
              children: <Widget>[Text(APP_DESCRIPTION)]);
        },
      ),
    );
    return Container(
      color: Color(0xFF303030),
      child: ListView(
        children: <Widget>[header]..addAll(aboutListTiles(context)),
      ),
    );
  }
}
