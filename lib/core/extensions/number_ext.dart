import 'package:flutter/widgets.dart';

extension NumberExt on num {
  num get _safeValue => this;

  Widget get spaceH => SizedBox(height: _safeValue.toDouble());

  Widget get spaceW => SizedBox(width: _safeValue.toDouble());

  Duration get ms => Duration(milliseconds: _safeValue.toInt());

  Duration get sec => Duration(seconds: _safeValue.toInt());

  Duration get min => Duration(minutes: _safeValue.toInt());
}
