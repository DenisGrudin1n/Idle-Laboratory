import 'package:idle_laboratory/core/utils/big_number.dart';

extension BigNumberExt on BigNumber {
  bool get isZero => mantissa == 0;
  bool get isPositive => mantissa > 0;
  bool get isNegative => mantissa < 0;

  BigNumber abs() => BigNumber(mantissa.abs(), exponent);

  BigNumber divide(BigNumber other) =>
      other.isZero ? BigNumber.zero() : BigNumber(mantissa / other.mantissa, exponent - other.exponent);

  BigNumber scale(double scalar) => BigNumber(mantissa * scalar, exponent);

  BigNumber min(BigNumber other) => this < other ? this : other;

  BigNumber max(BigNumber other) => this > other ? this : other;

  BigNumber clamp(BigNumber min, BigNumber max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  BigNumber pow(int power) {
    if (power == 0) return BigNumber(1, 0);
    if (power == 1) return this;
    if (power < 0) return BigNumber(1, 0).divide(pow(-power));

    var result = this;
    for (var i = 1; i < power; i++) result = result * this;
    return result;
  }

  String formatCompact() => format(compact: true);
  String formatScientific() => format(useScientific: true);
  String formatFull() => format();

  String formatPercent({int decimals = 0}) => '${(toDouble() * 100).toStringAsFixed(decimals)}%';
}
