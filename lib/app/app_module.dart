import 'package:flutter_modular/flutter_modular.dart';
import 'package:offline_first/app/modules/home/presenter/pages/dash_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const DashPage()),
      ];
}
