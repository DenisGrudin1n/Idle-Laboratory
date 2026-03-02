import 'package:get_it/get_it.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/cell_repository.dart';
import 'package:idle_laboratory/features/home/data/repositories/prestige_repository.dart';
import 'package:idle_laboratory/features/home/data/repositories/prestige_repository_impl.dart';
import 'package:idle_laboratory/features/home/data/repositories/settings_repository.dart';
import 'package:idle_laboratory/features/home/data/repositories/settings_repository_impl.dart';
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

  // Data Sources
  sl.registerLazySingleton<LocalStorageDataSource>(
    () => LocalStorageDataSource(sl<SharedPreferences>()),
  );

  // Repositories
  sl.registerLazySingleton<CellRepository>(() => const CellRepository());
  sl.registerLazySingleton<PrestigeRepository>(
    () => PrestigeRepositoryImpl(sl<LocalStorageDataSource>()),
  );
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl<LocalStorageDataSource>()),
  );

  // Services (Singletons - they manage state via streams)
  sl.registerLazySingleton<EnergyService>(
    () => EnergyService(),
    dispose: (EnergyService service) => service.dispose(),
  );
  sl.registerLazySingleton<PrestigeService>(
    () => PrestigeService(sl<EnergyService>(), sl<PrestigeRepository>()),
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
  sl.registerFactory<SettingsCubit>(
    () => SettingsCubit(sl<SettingsRepository>()),
  );
}

/// Call this on app shutdown / test teardown to dispose all registered services.
Future<void> disposeInjection() async {
  await sl.reset(dispose: true);
}
