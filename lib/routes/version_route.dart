import 'package:flutter/material.dart';
import '../get_data.dart';
import '../get_version.dart';
import '../route.dart';

class DisplayVersion extends MyRoute {
  const DisplayVersion([String sourceFile = 'lib/routes/version_route.dart'])
      : super(sourceFile);

  @override
  get title => 'Version';

  @override
  get links =>
      {'Doc': 'https://docs.flutter.io/flutter/material/TabBar-class.html'};

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:     FutureBuilder<String>(
            future: GetVersionPlugin.version,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return Text(snapshot.data);
            }
        ));
  }
}
