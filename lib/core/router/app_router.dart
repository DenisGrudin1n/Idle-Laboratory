import 'package:go_router/go_router.dart';
import 'package:idle_laboratory/features/home/presentation/screens/cells_screen.dart';

class AppRouter {
  AppRouter._();

  static const home = '/';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const CellsScreen(),
      ),
    ],
  );
}
