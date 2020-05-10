import 'package:flutter/material.dart';
import 'package:gclone_flutter/animations/slide_in.dart';
import 'package:gclone_flutter/models/get_data.dart';
import 'package:gclone_flutter/models/provider_data.dart';

import '../detail_page.dart';

const appTitle = "gclone";
bool startCompleted = false;

class JobStatus extends StatefulWidget {
  @override
  _JobStatusState createState() => _JobStatusState();
}

class _JobStatusState extends State<JobStatus> with TickerProviderStateMixin {
  List remotes = [];
  List lessons;
  List<CardDetails> _remotesList;
  var renderBuilder = true;

  // --- Init State -------------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
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
    ListTile _buildListTile(CardDetails item, ProviderData lesson) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(item.icon),
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
                    child: Text(lesson.status,
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing: _buildOptions(item),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(providerData: lesson)));
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
        return _remotesList
            .map((CardDetails item) => SlideFadeIn(
                  Key(item.key),
                  (double.parse(item.key) * 0.3) + 0.5,
                  makeCard(context, item, lessons[int.parse(item.key)]),
                ))
            .toList();
      } else {
        return _remotesList
            .map(
              (CardDetails item) =>
                  makeCard(context, item, lessons[int.parse(item.key)]),
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
                if (newIndex > _remotesList.length)
                  newIndex = _remotesList.length;
                if (oldIndex < newIndex) newIndex--;

                CardDetails item = _remotesList[oldIndex];
                _remotesList.remove(item);
                _remotesList.insert(newIndex, item);
              });
            }));

    return Scaffold(
      //backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: makeBody,
      //bottomNavigationBar: makeBottom,
    );
  }

  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    //setupComplete = true;
  }
}

List getLessons() {
  return [
    ProviderData(
        provider: "Google Drive",
        status: "Last run: Successful",
        indicatorValue: 1,
        price: 20,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    ProviderData(
        provider: "Google Cloud",
        status: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    ProviderData(
        provider: "Secure FTP",
        status: "Last run: Error",
        indicatorValue: 0,
        price: 30,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    ProviderData(
        provider: "Local Storage (USB)",
        status: "Last run: Successful",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
  ];
}
