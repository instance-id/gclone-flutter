import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gclone_flutter/animations/slide_in.dart';
import 'package:gclone_flutter/helpers/animate_route.dart';
import 'package:gclone_flutter/models/get_data.dart';
import 'package:gclone_flutter/models/provider_data.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../detail_page.dart';

const appTitle = "gclone";
bool startCompleted = false;

class Remotes extends StatefulWidget {
  @override
  _RemotesState createState() => _RemotesState();
}

class _RemotesState extends State<Remotes> with TickerProviderStateMixin {
  final Logger log = new Logger('Remotes');

  @override
  void initState() {
    super.initState();
  }

  var renderBuilder = true;

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
    var data = Provider.of<GetDataPlugin>(context);
    var providerData = data.providerList;
    var remotesList = data.remotesList;
    timeDilation = 2;

    ListTile _buildListTile(CardDetails item, ProviderData providerInfo) =>
        ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Hero(
              createRectTween: _createRectTween,
              tag: providerInfo.key = item.key,
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
                        value: providerInfo.indicatorValue,
                        valueColor: AlwaysStoppedAnimation(Colors.green)),
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(providerInfo.status,
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
                builder: (context) => DetailPage(providerData: providerInfo),
              ),
            );
          },
        );

    Card makeCard(BuildContext context, CardDetails item,
            ProviderData providerInfo) =>
        Card(
          key: Key(item.key),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: _buildListTile(item, providerInfo),
          ),
        );

    buildChildren(bool startCompleted) {
      if (!setupComplete) {
        return remotesList
            .map((CardDetails item) => SlideFadeIn(
                Key(item.key),
                (double.parse(item.key) * 0.3) + 0.5,
                makeCard(context, item, data.getProvider(item))))
            .toList();
      } else {
        return remotesList
            .map((CardDetails item) =>
                makeCard(context, item, data.getProvider(item)))
            .toList();
      }
    }

    Widget listViewData() {
      return ReorderableListView(
          padding: EdgeInsets.only(top: 20.0),
          children: buildChildren(startCompleted),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              // These two lines are workarounds for ReorderableListView problems
              if (newIndex > remotesList.length) newIndex = remotesList.length;
              if (oldIndex < newIndex) newIndex--;
              CardDetails item = remotesList[oldIndex];
              remotesList.remove(item);
              remotesList.insert(newIndex, item);
            });
          });
    }

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: listViewData(),
    );

    return Scaffold(
      body: makeBody,
    );
  }
}
