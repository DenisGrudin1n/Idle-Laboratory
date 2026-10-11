import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idle_laboratory/app/app_widget.dart';
import 'package:idle_laboratory/core/helper/get_it_service_locator.dart';
import 'package:idle_laboratory/core/router/app_router.dart';
import 'package:idle_laboratory/features/home/domain/services/app_lifecycle_service.dart';
import 'package:idle_laboratory/features/home/presentation/screens/cells_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  // Eagerly construct the lifecycle observer (persist on pause/hidden/detached).
  registerAppLifecycleObserver();
  AppRouter.configure(homeBuilder: (context, state) => const CellsScreen());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(const AppWidget());
}

/// Resolves [AppLifecycleService] so its [WidgetsBindingObserver] is attached.
void registerAppLifecycleObserver() {
  getIt<AppLifecycleService>();
}
