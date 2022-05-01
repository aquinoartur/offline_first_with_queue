import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:offline_first/app/modules/home/home_module.dart';
import 'package:offline_first/app/shared/connectivity/connectivity_service.dart';
import 'package:offline_first/app/shared/db/attendance_database.dart';

import 'app_guards.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<FirebaseFirestore>((i) => FirebaseFirestore.instance),
        Bind.singleton<FirebaseStorage>((i) => FirebaseStorage.instance),
        Bind.singleton<AttendanceDatabase>((i) => AttendanceDatabase.instance),
        Bind.singleton((i) => ConnectivityService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: HomeModule(),
          guards: [HomeGuard()],
        ),
      ];
}
