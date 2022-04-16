import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
