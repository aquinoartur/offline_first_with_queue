import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityService extends ChangeNotifier {
  late ConnectivityStatus value;

  Future<void> initStatus() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi) {
      value = ConnectivityStatus.online;
    } else {
      value = ConnectivityStatus.offline;
    }
    notifyListeners();
  }

  late final StreamSubscription subscription;
  ConnectivityService() {
    value = ConnectivityStatus.offline;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        value = ConnectivityStatus.online;
      } else {
        value = ConnectivityStatus.offline;
      }
      log('Status da conexão: $value');
      notifyListeners();
    });
  }

  bool get isOnline => value == ConnectivityStatus.online;
}
