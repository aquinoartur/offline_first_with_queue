import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
