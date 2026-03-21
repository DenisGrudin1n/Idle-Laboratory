import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idle_laboratory/app/app_widget.dart';
import 'package:idle_laboratory/core/helper/get_it_service_locator.dart';

import 'package:idle_laboratory/features/home/domain/services/app_lifecycle_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  getIt<AppLifecycleService>();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(const AppWidget());
}
