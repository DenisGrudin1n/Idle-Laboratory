import 'package:flutter/widgets.dart';

extension NumberExt on num {
  Widget get spaceH => SizedBox(height: toDouble());
  Widget get spaceW => SizedBox(width: toDouble());
  Duration get ms => Duration(milliseconds: toInt());
  Duration get sec => Duration(seconds: toInt());
  Duration get min => Duration(minutes: toInt());
}
