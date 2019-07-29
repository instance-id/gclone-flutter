import 'app_data.dart';

//class GcloneData extends StatefulWidget {
//  @override
//  _GcloneDataState createState() => _GcloneDataState();
//}
//
//class _GcloneDataState extends State<GcloneData> {
//  GetDataPlugin getDataPlugin = GetDataPlugin();
//
List<CardDetails> remotesList;
List remotes = [];
List providerData;
Map getData;
//
//  @override
//  void initState() {
//    providerData = getProviders();
//
//    getDataPlugin.getRemotes().then((getRemotes) {
//      setState(() {
//        remotes = getRemotes;
//        print(remotes[0]);
//        print(remotes[1]);
//        print(remotes[2]);
//      });
//      getDataPlugin.getData().then((data) {
//        setState(() {
//          getData = data;
//        });
//        print(getData[remotes[0]]["type"]);
//        var icon;
//        for (int i = 0; i < remotes.length; i++) {
//          if (getData[remotes[i]]["type"] == "drive") {
//            icon = getFontAwesomeIcon(name: "googleDrive");
//          } else if (getData[remotes[i]]["type"] == "sftp") {
//            icon = getFontAwesomeIcon(name: "solidFolder");
//          } else if (getData[remotes[i]]["type"] == "google cloud storage") {
//            icon = getFontAwesomeIcon(name: "google");
//          } else {
//            icon = randomIcons[i];
//          }
//          remotesList.add(CardDetails(i.toString(), icon, remotes[i]));
//        }
//      });
//    });
//    super.initState();
//
//
//    String _dataUrl = "https://reqres.in/api/users?per_page=20";
//    String _jsonResonse = "";
//    bool _isFetching = false;
//
//    bool get isFetching => _isFetching;
//
//    Future<void> fetchData() async {
//      _isFetching = true;
//      notifyListeners();
//
//      var response = await http.get(_dataUrl);
//      if (response.statusCode == 200) {
//        _jsonResonse = response.body;
//      }
//
//      _isFetching = false;
//      notifyListeners();
//    }
//
//    String get getResponseText => _jsonResonse;
//
//    List<dynamic> getResponseJson() {
//      if (_jsonResonse.isNotEmpty) {
//        Map<String, dynamic> json = jsonDecode(_jsonResonse);
//        return json['data'];
//      }
//      return null;
//    }
//
//    @override
//    // ignore: unused_element
//    Widget build(BuildContext context) {
//      // TODO: implement build
//      return null;
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return null;
//  }
//}
