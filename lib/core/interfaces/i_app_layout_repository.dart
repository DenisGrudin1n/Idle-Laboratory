import 'dart:ui';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';

abstract class IAppLayoutRepository {
  Stream<AppVersionEnum> get appVersionStream;
  AppVersionEnum get getCurrentAppVersion;
  Size? get getScreenSize;

  void dispose();
}
