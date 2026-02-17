import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idle_laboratory/features/home/presentation/screens/home_screen.dart';

class AppRouter {
  AppRouter._();

  static const String home = '/';

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
    ],
  );
}
