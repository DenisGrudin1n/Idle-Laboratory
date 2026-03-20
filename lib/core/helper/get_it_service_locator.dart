import 'package:get_it/get_it.dart';
import 'package:idle_laboratory/core/helper/get_it_service_locator.config.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() => getIt.init();
