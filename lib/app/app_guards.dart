import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:offline_first/app/shared/connectivity/connectivity_service.dart';

class HomeGuard extends RouteGuard {
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    await Modular.get<ConnectivityService>().initStatus();
    return true;
  }
}
