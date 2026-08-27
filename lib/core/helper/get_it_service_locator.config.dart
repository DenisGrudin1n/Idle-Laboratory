// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:idle_laboratory/core/helper/shared_preferences_module.dart'
    as _i62;
import 'package:idle_laboratory/core/interfaces/i_app_layout_repository.dart'
    as _i962;
import 'package:idle_laboratory/core/repositories/app_layout_repository.dart'
    as _i210;
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart'
    as _i241;
import 'package:idle_laboratory/features/home/data/repositories/cell_repository.dart'
    as _i588;
import 'package:idle_laboratory/features/home/data/repositories/cell_repository_impl.dart'
    as _i1003;
import 'package:idle_laboratory/features/home/data/repositories/energy_repository.dart'
    as _i312;
import 'package:idle_laboratory/features/home/data/repositories/energy_repository_impl.dart'
    as _i844;
import 'package:idle_laboratory/features/home/data/repositories/prestige_repository.dart'
    as _i495;
import 'package:idle_laboratory/features/home/data/repositories/prestige_repository_impl.dart'
    as _i362;
import 'package:idle_laboratory/features/home/data/repositories/production_repository.dart'
    as _i743;
import 'package:idle_laboratory/features/home/data/repositories/production_repository_impl.dart'
    as _i963;
import 'package:idle_laboratory/features/home/data/repositories/settings_repository.dart'
    as _i912;
import 'package:idle_laboratory/features/home/data/repositories/settings_repository_impl.dart'
    as _i5;
import 'package:idle_laboratory/features/home/data/repositories/storage_repository.dart'
    as _i495;
import 'package:idle_laboratory/features/home/data/repositories/storage_repository_impl.dart'
    as _i75;
import 'package:idle_laboratory/features/home/domain/services/app_lifecycle_service.dart'
    as _i159;
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart'
    as _i643;
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart'
    as _i57;
import 'package:idle_laboratory/features/home/domain/services/prestige_service.dart'
    as _i741;
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart'
    as _i540;
import 'package:idle_laboratory/features/home/domain/services/story_ending_service.dart'
    as _i515;
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart'
    as _i915;
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart'
    as _i461;
import 'package:idle_laboratory/features/home/presentation/blocs/crafting/crafting_bloc.dart'
    as _i965;
import 'package:idle_laboratory/features/home/presentation/blocs/energy/energy_bloc.dart'
    as _i951;
import 'package:idle_laboratory/features/home/presentation/blocs/navigation/navigation_bloc.dart'
    as _i249;
import 'package:idle_laboratory/features/home/presentation/blocs/prestige/prestige_bloc.dart'
    as _i89;
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart'
    as _i754;
import 'package:idle_laboratory/features/home/presentation/blocs/storage/badge/storage_badge_cubit.dart'
    as _i394;
import 'package:idle_laboratory/features/home/presentation/blocs/storage/storage_bloc.dart'
    as _i926;
import 'package:idle_laboratory/features/home/presentation/blocs/story_ending/story_ending_bloc.dart'
    as _i1007;
import 'package:idle_laboratory/features/home/presentation/blocs/story_prologue/prologue_dialog_cubit.dart'
    as _i881;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferencesModule = _$SharedPreferencesModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i249.NavigationBloc>(() => _i249.NavigationBloc());
    gh.factory<_i394.StorageBadgeCubit>(() => _i394.StorageBadgeCubit());
    gh.factory<_i881.PrologueDialogCubit>(() => _i881.PrologueDialogCubit());
    gh.singleton<_i962.IAppLayoutRepository>(() => _i210.AppLayoutRepository());
    gh.lazySingleton<_i241.LocalStorageDataSource>(
      () => _i241.LocalStorageDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i495.StorageRepository>(
      () => _i75.StorageRepositoryImpl(gh<_i241.LocalStorageDataSource>()),
    );
    gh.lazySingleton<_i743.ProductionRepository>(
      () => _i963.ProductionRepositoryImpl(gh<_i241.LocalStorageDataSource>()),
    );
    gh.singleton<_i915.AppLayoutBloc>(
      () => _i915.AppLayoutBloc(
        appLayoutRepository: gh<_i962.IAppLayoutRepository>(),
      ),
    );
    gh.lazySingleton<_i495.PrestigeRepository>(
      () => _i362.PrestigeRepositoryImpl(gh<_i241.LocalStorageDataSource>()),
    );
    gh.lazySingleton<_i515.StoryEndingService>(
      () => _i515.StoryEndingService(gh<_i241.LocalStorageDataSource>()),
    );
    gh.lazySingleton<_i540.StorageService>(
      () => _i540.StorageService(gh<_i495.StorageRepository>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i312.EnergyRepository>(
      () => _i844.EnergyRepositoryImpl(gh<_i241.LocalStorageDataSource>()),
    );
    gh.lazySingleton<_i588.CellRepository>(
      () => _i1003.CellRepositoryImpl(gh<_i241.LocalStorageDataSource>()),
    );
    gh.factory<_i926.StorageBloc>(
      () => _i926.StorageBloc(gh<_i540.StorageService>()),
    );
    gh.lazySingleton<_i912.SettingsRepository>(
      () => _i5.SettingsRepositoryImpl(gh<_i241.LocalStorageDataSource>()),
    );
    gh.factory<_i1007.StoryEndingBloc>(
      () => _i1007.StoryEndingBloc(
        gh<_i515.StoryEndingService>(),
        gh<_i540.StorageService>(),
      ),
    );
    gh.lazySingleton<_i57.EnergyService>(
      () => _i57.EnergyService(gh<_i312.EnergyRepository>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i951.EnergyBloc>(
      () => _i951.EnergyBloc(gh<_i57.EnergyService>()),
    );
    gh.factory<_i754.SettingsBloc>(
      () => _i754.SettingsBloc(gh<_i912.SettingsRepository>()),
    );
    gh.lazySingleton<_i741.PrestigeService>(
      () => _i741.PrestigeService(
        gh<_i57.EnergyService>(),
        gh<_i495.PrestigeRepository>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i643.CellsService>(
      () => _i643.CellsService(
        gh<_i588.CellRepository>(),
        gh<_i743.ProductionRepository>(),
        gh<_i57.EnergyService>(),
        gh<_i741.PrestigeService>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i965.CraftingBloc>(
      () => _i965.CraftingBloc(
        gh<_i643.CellsService>(),
        gh<_i57.EnergyService>(),
        gh<_i540.StorageService>(),
      ),
    );
    gh.factory<_i89.PrestigeBloc>(
      () => _i89.PrestigeBloc(
        gh<_i741.PrestigeService>(),
        gh<_i57.EnergyService>(),
        gh<_i643.CellsService>(),
      ),
    );
    gh.factory<_i461.CellsBloc>(
      () => _i461.CellsBloc(gh<_i643.CellsService>(), gh<_i57.EnergyService>()),
    );
    gh.lazySingleton<_i159.AppLifecycleService>(
      () => _i159.AppLifecycleService(
        gh<_i57.EnergyService>(),
        gh<_i643.CellsService>(),
        gh<_i741.PrestigeService>(),
      ),
      dispose: (i) => i.dispose(),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i62.SharedPreferencesModule {}
