import 'package:eterny_task/core/app.dart';
import 'package:eterny_task/core/app_setup.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await AppSetup.instance.init();

  runApp(const App());
}
