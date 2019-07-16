import 'dart:math';

import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gclone/route.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import '../app_meta.dart' show GITHUB_URL;
import '../get_data.dart';
import '../get_version.dart';

class Remotes extends StatefulWidget {
  //final String filePath;
  //const Remotes({Key key, this.filePath}) : super(key: key);

  //String get githubPath => '$GITHUB_URL/blob/master/${this.filePath}';

  @override
  RemotesState createState() {
    return RemotesState();
  }
}

buildFutureBuilder() {
  return FutureBuilder<String>(
      future: GetVersionPlugin.version,
      builder: (c, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return Text(snapshot.data);
      });
}

  FutureBuilder<String> getVersion() => new FutureBuilder<String>(
      future: GetVersionPlugin.version,
      builder: (c, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return Text(snapshot.data);
      });

class RemotesState extends State<Remotes> {
  double _textScaleFactor = 1.0;

  List<Widget> _buildFloatingButtons() {
    return <Widget>[
      FloatingActionButton(
        child: Icon(Icons.open_in_new),
        tooltip: 'Vawdawd on github',
        onPressed: () => url_launcher.launch("google.com"),
      ),
      FloatingActionButton(
        child: Icon(Icons.zoom_out),
        tooltip: 'Zoom out',
        onPressed: () => setState(() {
          this._textScaleFactor = max(0.8, this._textScaleFactor - 0.1);
        }),
      ),
      FloatingActionButton(
        child: Icon(Icons.zoom_in),
        tooltip: 'Zoom in',
        onPressed: () => setState(() {
          this._textScaleFactor += 0.1;
        }),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Loading string from file returns a Future<String>, so instead of returning directly the
    // widget, we need a FutureBuilder.
//    return Scaffold(
//      body: getVersion(),
//      floatingActionButton: AnimatedFloatingActionButton(
//        fabButtons: _buildFloatingButtons(),
//        colorStartAnimation: Colors.blue,
//        colorEndAnimation: Colors.red,
//        animatedIconData: AnimatedIcons.menu_close,
//      ),
//    );

    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<Map>(
            future: GetDataPlugin.remotesGet,
            builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
            Map data = snapshot.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(data[index]),
                      )
                    ],
                  );
                },
              );
            }
        )
    );
  }
}
