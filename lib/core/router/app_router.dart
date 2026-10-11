import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// App shell router. Home route is injected from `lib/app` / `main` so core
/// does not import feature screens.
class AppRouter {
  AppRouter._();

  static const home = '/';

  static GoRouter? _router;

  static GoRouter get router {
    final configured = _router;
    if (configured == null) {
      throw StateError('AppRouter.configure must be called before using AppRouter.router');
    }
    return configured;
  }

  static void configure({required Widget Function(BuildContext context, GoRouterState state) homeBuilder}) {
    _router = GoRouter(
      routes: [
        GoRoute(
          path: home,
          builder: homeBuilder,
        ),
      ],
    );
  }
}
