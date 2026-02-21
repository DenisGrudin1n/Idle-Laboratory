import 'package:get_it/get_it.dart';
import 'package:idle_laboratory/features/home/data/repositories/cell_repository.dart';
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

  // Cubits
  sl.registerFactory<EnergyCubit>(() => EnergyCubit());
  sl.registerFactory<SettingsCubit>(() => SettingsCubit());
  sl.registerFactory<CellsCubit>(() => CellsCubit(sl()));
}
