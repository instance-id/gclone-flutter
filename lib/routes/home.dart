import 'package:flutter/material.dart';
import 'package:gclone/get_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../get_version.dart';
import '../route.dart';
import '../app_meta.dart'
    show
    BookmarkManager,
    kAboutRoute,
    kMyAppRoutesStructure,
    kRoutenameToRouteMap,
    kSharedPreferences,
    MyRouteGroup;


class HomeRoute extends MyRoute {
  const HomeRoute([String sourceFile = 'lib/routes/home.dart'])
      : super(sourceFile);

  @override
  get title => 'Gclone';

  @override
  get routeName => Navigator.defaultRouteName;

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _ListItem {
  _ListItem(this.value, this.checked);
  final String value;
  bool checked;
}

class _HomePageState extends State<HomePage> {
  GetDataPlugin getdataPlugin = GetDataPlugin();
  List remotes =[];

  SharedPreferences _preferences;
  bool _isRow = true;
  MainAxisSize _mainAxisSize = MainAxisSize.max;
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.start;

  @override
  void initState() {
    super.initState();
    kSharedPreferences
      ..then((prefs) => setState(() => this._preferences = prefs));

    getdataPlugin.remotesGetData().then((data){
      setState(() {
      remotes = data;
      });
    });
  }

  // Loads boolean preference into this._numberPref.
  void _loadBooleanPref() {
    setState(() {
      this._boolPref = this._preferences.getBool(kDemoBooleanPrefKey) ?? false;
    });
  }

  Future<Null> _setBooleanPref(bool val) async {
    await this._preferences.setBool(kDemoBooleanPrefKey, val);
    _loadBooleanPref();
  }
  static const String kDemoBooleanPrefKey = 'demo_boolean_pref';
  bool _boolPref = false;

  @override
  Widget build(BuildContext context) {
    final _appbarButtons = _getBottomBar();
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _appbarButtons,
    );
  }

  bool _reverseSort = false;

  // Handler called by ReorderableListView onReorder after a list child is
  // dropped into a new position.
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex = -1;
      }
      final _ListItem item = remotes.removeAt(oldIndex);
      remotes.insert(newIndex, item);
    });
  }

  // Handler called when the "sort" button on appbar is clicked.
//  void _onSort() {
//    setState(() {
//      _reverseSort = !_reverseSort;
//      remotes.sort((_ListItem a, _ListItem b) => _reverseSort
//          ? b.value.compareTo(a.value)
//          : a.value.compareTo(b.value));
//    });
//  }

  Widget _buildBody() {
    return FutureBuilder<List<dynamic>>(
        future: GetDataPlugin.remotesGet,
        builder:  (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
          if (!snapshot.hasData) {
            return Container();
          }
          var _items = snapshot.data.map((item) =>
                                              _ListItem(item, false)).toList();
          return ReorderableListView(
            padding:new EdgeInsets.symmetric(vertical: 16.0),
            onReorder: _onReorder,
            children: _items
              .map((item) =>
              CheckboxListTile(
            key: Key(item.value),
            value: item.checked ?? false,
            onChanged: (bool newValue) {
              setState(() => item.checked = newValue);
            },
            title: Text('${item.value}'),
            isThreeLine: true,
            subtitle: Text('${item.value}, checked=${item.checked}'),
            secondary: Icon(Icons.drag_handle),

          ),
          ).toList());
          });

  }

  // --- Bottom buttons ----------------------------------------------------------------------------------------------------

  Widget _getBottomBar() {
    return Material(
      color: Theme.of(context).primaryColor,
      //child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        //Row(
        child: ButtonBar(
          children: <Widget>[
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Text('New'),
                  onPressed: () => this._setBooleanPref(!this._boolPref),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Text('Edit'),
                  onPressed: () => this._setBooleanPref(!this._boolPref),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Text('Delete'),
                  onPressed: () => this._setBooleanPref(!this._boolPref),
                ),
              ],
            ),
          ],
        ));
    //  ]),
  //  );
  }
}
