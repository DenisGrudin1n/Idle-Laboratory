import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/helper/get_it_service_locator.dart';
import 'package:idle_laboratory/core/router/app_router.dart';
import 'package:idle_laboratory/core/theme/app_theme.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/energy/energy_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/prestige/prestige_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<EnergyBloc>()..add(const EnergyEvent.start()),
        ),
        BlocProvider(
          create: (_) =>
              getIt<PrestigeBloc>()..add(const PrestigeEvent.start()),
        ),
        BlocProvider(create: (_) => getIt<SettingsBloc>()),
        BlocProvider(
          create: (_) => getIt<CellsBloc>()..add(const CellsEvent.start()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(
          390 * (MediaQuery.sizeOf(context).width / 390),
          844 * (MediaQuery.sizeOf(context).height / 844),
        ),
        splitScreenMode: true,
        child: MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
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
        ),
      ),
    );
  }
}
