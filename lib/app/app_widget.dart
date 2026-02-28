import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/injection.dart';
import 'package:idle_laboratory/core/router/app_router.dart';
import 'package:idle_laboratory/core/theme/app_theme.dart';
import 'package:idle_laboratory/features/home/presentation/cubits/cubits.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<EnergyCubit>(
          create: (BuildContext context) {
            final EnergyCubit energyCubit = sl<EnergyCubit>();
            energyCubit.start();
            return energyCubit;
          },
        ),
        BlocProvider<PrestigeCubit>(
          create: (BuildContext context) {
            final PrestigeCubit prestigeCubit = sl<PrestigeCubit>();
            prestigeCubit.start();
            return prestigeCubit;
          },
        ),
        BlocProvider<SettingsCubit>(
          create: (BuildContext context) => sl<SettingsCubit>(),
        ),
        BlocProvider<CellsCubit>(
          create: (BuildContext context) {
            final CellsCubit cellsCubit = sl<CellsCubit>();
            cellsCubit.start();
            return cellsCubit;
          },
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
          ).copyWith(textScaler: const TextScaler.linear(1)),
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
            theme: AppTheme.defaultTheme,
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const <Locale>[Locale('en')],
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
