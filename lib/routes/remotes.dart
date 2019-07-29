import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gclone/animations/slide_in.dart';
import 'package:gclone/helpers/animate_route.dart';
import 'package:gclone/helpers/icons.dart';
import 'package:gclone/helpers/icons_helper.dart';
import 'package:gclone/models/app_data.dart';
import 'package:gclone/models/gclone_data.dart';
import 'package:gclone/models/get_data.dart';
import 'package:gclone/models/provider_data.dart';

import '../detail_page.dart';

const appTitle = "gclone";
bool startCompleted = false;

class Remotes extends StatefulWidget {
  @override
  _RemotesState createState() => _RemotesState();
}

class _RemotesState extends State<Remotes> with TickerProviderStateMixin {
  GetDataPlugin getDataPlugin = GetDataPlugin();
//  List remotes = [];
//  Map getData;
//  List providerData;
//  List<CardDetails> _remotesList;
  var renderBuilder = true;

  // --- Init State -------------------------------------------------------------------------------
  @override
  void initState() {
    providerData = getProviderList();
    remotesList = [];
    getDataPlugin.getRemotes().then((getRemotes) {
      setState(() {
        remotes = getRemotes;
        print(remotes[0]);
        print(remotes[1]);
        print(remotes[2]);
      });
      getDataPlugin.getData().then((data) {
        setState(() {
          getData = data;
        });
        print(getData[remotes[0]]["type"]);
        var icon;
        for (int i = 0; i < remotes.length; i++) {
          if (getData[remotes[i]]["type"] == "drive") {
            icon = getFontAwesomeIcon(name: "googleDrive");
          } else if (getData[remotes[i]]["type"] == "sftp") {
            icon = getFontAwesomeIcon(name: "solidFolder");
          } else if (getData[remotes[i]]["type"] == "google cloud storage") {
            icon = getFontAwesomeIcon(name: "google");
          } else {
            icon = randomIcons[i];
          }
          remotesList.add(CardDetails(i.toString(), icon, remotes[i]));
        }
      });
    });
    super.initState();
  }

  RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  Widget _buildOptions(CardDetails item) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          new PopupMenuItem(child: new Text("edit"), value: "edit"),
          new PopupMenuItem(child: new Text("delete"), value: "delete"),
        ];
      },
      onSelected: (selected) async {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text(selected),
                contentPadding: EdgeInsets.all(25.0),
                children: <Widget>[
                  Text("Item [${item.title}], Operation [$selected].")
                ],
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2;
    //final navigation = Provider.of<NavigationProvider>(context);
    ListTile _buildListTile(CardDetails item, ProviderData lesson) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Hero(
              createRectTween: _createRectTween,
              tag: lesson.key = item.key,
              child: Icon(item.icon),
            ),
          ),
          title: Text(item.title),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    // tag: 'hero',
                    child: LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                        value: lesson.indicatorValue,
                        valueColor: AlwaysStoppedAnimation(Colors.green)),
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(lesson.level,
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing: _buildOptions(item),
          onTap: () {
            Navigator.push(
              context,
              AnimateRoute(
                fullscreenDialog: true,
                builder: (context) => DetailPage(providerData: lesson),
              ),
            );
          },
        );

    Card makeCard(
            BuildContext context, CardDetails item, ProviderData lesson) =>
        Card(
            key: Key(item.key),
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              child: _buildListTile(item, lesson),
            ));

    buildChildren(bool startCompleted) {
      if (!setupComplete) {
        return remotesList
            .map((CardDetails item) => SlideFadeIn(
                  Key(item.key),
                  (double.parse(item.key) * 0.3) + 0.5,
                  makeCard(context, item, providerData[int.parse(item.key)]),
                ))
            .toList();
      } else {
        return remotesList
            .map(
              (CardDetails item) =>
                  makeCard(context, item, providerData[int.parse(item.key)]),
            )
            .toList();
      }
    }

    final makeBody = Container(
        // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
        child: ReorderableListView(
            padding: EdgeInsets.only(top: 20.0),
            children: buildChildren(startCompleted),
            onReorder: (oldIndex, newIndex) {
              setState(() {
                // These two lines are workarounds for ReorderableListView problems
                if (newIndex > remotesList.length)
                  newIndex = remotesList.length;
                if (oldIndex < newIndex) newIndex--;

                CardDetails item = remotesList[oldIndex];
                remotesList.remove(item);
                remotesList.insert(newIndex, item);
              });
            }));

    return Scaffold(
      //backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: makeBody,
      //bottomNavigationBar: makeBottom,
    );
  }
}
