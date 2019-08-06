import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gclone/helpers/icons.dart';
import 'package:gclone/helpers/icons_helper.dart';
import 'package:gclone/models/provider_data.dart';
import 'package:logging/logging.dart';

class GetDataPlugin with ChangeNotifier {
  final Logger log = new Logger('GetDataPlugin');
  static const _channel = const MethodChannel("instance.id/go/data");
  ProviderData _selectedProvider = new ProviderData();
  int _selectedProviderID;
  List<ProviderData> providerList;
  List<ProviderData> providerMapping;

  List<CardDetails> remotesList = [];

  List futureRemotes = [];
  Map<dynamic, dynamic> rcloneData;

  GetDataPlugin() {
    providerList = ProviderData().getList();
    notifyListeners();
  }

  init() async {
    await getData().then((getData) {
      this.rcloneData = getData;
      this.rcloneData.forEach((k, v) => {this.futureRemotes.add(k)});
      this.remotesList = buildCards(this.futureRemotes, this.rcloneData);
      notifyListeners();
      return this.remotesList;
    });
  }

  setInitialDetails(int detailID) {
    _selectedProvider = getProviderByID(detailID);
    _selectedProviderID = detailID;
  }

  setCurrentDetails(int detailID) {
    _selectedProvider = getProviderByID(detailID);
    _selectedProviderID = detailID;
    notifyListeners();
  }

  getCurrentDetails() {
    return _selectedProvider;
  }

  getCurrentDetailsID() {
    return _selectedProviderID;
  }

  getProvider(item) {
    providerMapping = providerList
        .where((data) => data.providerID == item.providerID)
        .toList();
    return providerMapping[0];
  }

  getProviderByID(item) {
    var mapping =
        providerList.where((data) => data.providerID == item).toList();
    return mapping[0];
  }

  Future<List<dynamic>> getRemotes() async {
    return await _channel.invokeMethod('getRemotes', {});
  }

  Future<Map<dynamic, dynamic>> getData() async {
    return await _channel.invokeMethod('getData', {});
  }

  Future<List<dynamic>> get remotesGet async {
    futureRemotes = await _channel.invokeMethod('getRemotes', {});
    notifyListeners();
    return futureRemotes;
  }

  buildCards(List futureRemotes, Map rcloneData) {
    List<CardDetails> rl = [];

    try {
      for (int i = 0; i < futureRemotes.length; i++) {
        var icon;
        var providerID;

        if (rcloneData[futureRemotes[i]]["type"] == "drive") {
          providerID = 12;
          icon = getFontAwesomeIcon(name: "googleDrive");
        } else if (rcloneData[futureRemotes[i]]["type"] == "sftp") {
          providerID = 21;
          icon = getFontAwesomeIcon(name: "solidFolder");
        } else if (rcloneData[futureRemotes[i]]["type"] ==
            "google cloud storage") {
          providerID = 11;
          icon = getFontAwesomeIcon(name: "google");
        } else {
          icon = randomIcons[i];
        }

        try {
          rl.add(CardDetails(i.toString(), providerID, icon, futureRemotes[i]));
        } catch (e) {}
      }
    } catch (e) {
      log.warning("Could not get data in time!");
    }

    return rl;
  }
}

class CardDetails {
  CardDetails(this.key, this.providerID, this.icon, this.title);

  final String key;
  final int providerID;
  final IconData icon;
  final String title;

  bool operator ==(o) => o is CardDetails && o.key == key;
  int get hashCode => key.hashCode;
}

//  retrieveData() {
//    log.shout(
//        "CHECK MY TIME!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! - PROVIDERDATASTART");
//    getRemotes().then((getRemotes) {
//      futureRemotes = getRemotes;
//      getData().then((data) {
//        rcloneData = data;
//        log.shout(
//            "CHECK MY TIME!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! - PROVIDERDATADONE");
//        return [futureRemotes, rcloneData];
//      });
//      notifyListeners();
//    });
//  }
//
//  retrieveRemotes() {
//    getRemotes().then((getRemotes) {
//      List remotes = getRemotes;
//      return remotes;
//    });
//  }
//
//  retrieverClone() {
//    getData().then((data) {
//      Map d = data;
//      return d;
//    });
//  }

//
//  Future<List<dynamic>> getRemotes2() async {
//    remotes = await _channel.invokeMethod('getRemotes', {});
//    notifyListeners();
//    return remotes;
//  }

//class GetProviderData with ChangeNotifier {
//  getRemotes2() {}
//  final List<String> tmp = notifyListeners();
//}

//  static Future<Map> get getData async => _channel.invokeMethod("getData");
//  static Future<List<String>> get getRemotes async =>
//      _channel.invokeMethod("getRemotes");

//  static Future<Map> get dataGet async {
//    final Map data = await _channel.invokeMethod('getData', {});
//    return data;
//  }

//  static Future<List<dynamic>> get remotesGet async {
//    final List<dynamic> data = await _channel.invokeMethod('getRemotes', {});
//    return data;
//  }

// ignore: unused_local_variable
//    var tmp = () async {
//      await getRemotes().then((getRemotes) {
//        futureRemotes = getRemotes;
//        getData().then((getData) {
//          rcloneData = getData;
//          log.shout("CHECK MY TIME!!!!!!!!!!!!! - rClone");
//          remotesList = buildCards(futureRemotes, rcloneData);
//          setupComplete = true;
//        });
//      });
//    };

//
