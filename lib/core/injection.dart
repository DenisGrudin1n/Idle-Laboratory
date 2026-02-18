import 'package:get_it/get_it.dart';
import 'package:idle_laboratory/features/home/presentation/cubits/cubits.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Initialize SharedPreferences
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Cubits
  sl.registerFactory<EnergyCubit>(() => EnergyCubit());
  sl.registerFactory<SettingsCubit>(() => SettingsCubit());
}
