import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idle_laboratory/app/app_widget.dart';
import 'package:idle_laboratory/core/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const AppWidget());
}
