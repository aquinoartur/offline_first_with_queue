import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      title: 'My Smart App',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension
  }
}
