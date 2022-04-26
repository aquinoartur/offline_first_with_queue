import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:offline_first/app/modules/home/presenter/pages/dash/dash_page.dart';

import 'modules/home/presenter/pages/add/add_page.dart';
import 'modules/home/presenter/pages/home/home_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<FirebaseFirestore>((i) => FirebaseFirestore.instance),
        Bind.singleton<FirebaseStorage>((i) => FirebaseStorage.instance),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const DashPage()),
        ChildRoute('/home', child: (context, args) => const HomePage()),
        ChildRoute('/add', child: (context, args) => const AddPage()),
      ];
}
