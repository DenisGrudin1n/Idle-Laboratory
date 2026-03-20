import 'package:flutter/material.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

extension BuildContextExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  bool get isDarkMode => theme.brightness == Brightness.dark;

  void showSnackBar(String message, {Duration duration = const Duration(seconds: 2)}) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message), duration: duration));

  void hideKeyboard() => FocusScope.of(this).unfocus();

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);

  void pop<T>([T? result]) => Navigator.of(this).pop(result);
}
