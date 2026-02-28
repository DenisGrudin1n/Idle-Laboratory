import 'package:get_it/get_it.dart';
import 'package:idle_laboratory/features/home/data/repositories/cell_repository.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/prestige_service.dart';
import 'package:idle_laboratory/features/home/presentation/cubits/cubits.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Initialize SharedPreferences
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Repositories
  sl.registerLazySingleton<CellRepository>(() => const CellRepository());

  // Services (Singletons - they manage state via streams)
  sl.registerLazySingleton<EnergyService>(
    () => EnergyService(),
    dispose: (EnergyService service) => service.dispose(),
  );
  sl.registerLazySingleton<PrestigeService>(
    () => PrestigeService(sl<EnergyService>(), sl<SharedPreferences>()),
    dispose: (PrestigeService service) => service.dispose(),
  );
  sl.registerLazySingleton<CellsService>(
    () => CellsService(
      sl<CellRepository>(),
      sl<EnergyService>(),
      sl<PrestigeService>(),
    ),
    dispose: (CellsService service) => service.dispose(),
  );

  // Cubits (UI state wrappers around services)
  sl.registerFactory<EnergyCubit>(() => EnergyCubit(sl<EnergyService>()));
  sl.registerFactory<CellsCubit>(
    () => CellsCubit(sl<CellsService>(), sl<EnergyService>()),
  );
  sl.registerFactory<PrestigeCubit>(
    () => PrestigeCubit(
      sl<PrestigeService>(),
      sl<EnergyService>(),
      sl<CellsService>(),
    ),
  );
  sl.registerFactory<SettingsCubit>(() => SettingsCubit());
}

/// Call this on app shutdown / test teardown to dispose all registered services.
Future<void> disposeInjection() async {
  await sl.reset(dispose: true);
}
