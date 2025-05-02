import 'package:flutter/material.dart';
import 'package:kursol/core/database/hive_initializer.dart';

import 'core/di/service_locator.dart';
import 'features/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInitializer.init();
  await setupServiceLocator();
  runApp(const MyApp());
}
