import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/helper/get_it_service_locator.dart';
import 'package:idle_laboratory/core/router/app_router.dart';
import 'package:idle_laboratory/core/theme/app_theme.dart';
import 'package:idle_laboratory/core/widgets/cell_loop_animation_scope.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/crafting/crafting_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/energy/energy_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/prestige/prestige_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/storage/badge/storage_badge_cubit.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/storage/storage_bloc.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => getIt<NavigationBloc>()),
      BlocProvider(create: (_) => getIt<EnergyBloc>()..add(const EnergyEvent.start())),
      BlocProvider(create: (_) => getIt<PrestigeBloc>()..add(const PrestigeEvent.start())),
      BlocProvider(create: (_) => getIt<SettingsBloc>()),
      BlocProvider(create: (_) => getIt<CellsBloc>()..add(const CellsEvent.start())),
      BlocProvider(create: (_) => getIt<CraftingBloc>()),
      BlocProvider(create: (_) => getIt<StorageBloc>()),
      BlocProvider(create: (_) => getIt<StorageBadgeCubit>()),
      BlocProvider(create: (_) => getIt<AppLayoutBloc>()),
    ],
    child: CellLoopAnimationScope(
      child: BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
        selector: (state) => state.appVersion,
        builder: (context, appVersion) {
          final textScale = switch (appVersion) {
            AppVersionEnum.mobile => 1.0,
            AppVersionEnum.tablet => 1.0,
            AppVersionEnum.desk => 1.25,
          };

          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
            child: MaterialApp.router(
              routerConfig: AppRouter.router,
              theme: AppTheme.defaultTheme,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en')],
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    ),
  );
}
