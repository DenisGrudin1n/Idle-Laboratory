import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idle_laboratory/app/app_widget.dart';
import 'package:idle_laboratory/core/helper/get_it_service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(const AppWidget());
}
