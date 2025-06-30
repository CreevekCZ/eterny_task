import 'package:eterny_task/di.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart';

class AppSetup {
  AppSetup._();

  static AppSetup instance = AppSetup._();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _setupDependencies();
    await setupTimezone();
  }

  Future<void> _setupDependencies() async {
    await configureDependencies();
  }

  Future<void> setupTimezone() async {
    initializeTimeZones();
  }
}
