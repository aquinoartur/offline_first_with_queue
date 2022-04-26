import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityService {
  late ConnectivityStatus status;

  Future<void> initStatus() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      status = ConnectivityStatus.online;
    } else {
      status = ConnectivityStatus.offline;
    }
  }

  late final StreamSubscription subscription;
  ConnectivityService() {
    initStatus().then((_) {
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          status = ConnectivityStatus.online;
        } else {
          log('Você não tem conexão');
          status = ConnectivityStatus.offline;
        }
        log('Status da conexão: $status');
      });
    });
  }

  bool get isOnline => status == ConnectivityStatus.online;
  void dispose() => subscription.cancel();
}
