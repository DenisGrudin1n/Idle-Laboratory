import 'package:idle_laboratory/core/utils/big_number.dart';

/// Extension methods for BigNumber providing convenience helpers.
extension BigNumberExt on BigNumber {
  /// Returns true if this number is zero.
  bool get isZero => mantissa == 0;

  /// Returns true if this number is positive.
  bool get isPositive => mantissa > 0;

  /// Returns true if this number is negative.
  bool get isNegative => mantissa < 0;

  /// Returns the absolute value of this number.
  BigNumber abs() => BigNumber(mantissa.abs(), exponent);

  /// Divides this number by another BigNumber.
  /// Returns zero if dividing by zero.
  BigNumber divide(BigNumber other) {
    if (other.isZero) {
      return BigNumber.zero();
    }
    return BigNumber(mantissa / other.mantissa, exponent - other.exponent);
  }

  /// Multiplies this number by a scalar value.
  BigNumber scale(double scalar) {
    return BigNumber(mantissa * scalar, exponent);
  }

  /// Returns the smaller of this number and another.
  BigNumber min(BigNumber other) {
    return this < other ? this : other;
  }

  /// Returns the larger of this number and another.
  BigNumber max(BigNumber other) {
    return this > other ? this : other;
  }

  /// Clamps this number between a minimum and maximum value.
  BigNumber clamp(BigNumber min, BigNumber max) {
    if (this < min) {
      return min;
    }
    if (this > max) {
      return max;
    }
    return this;
  }

  /// Returns this number raised to the power of an integer exponent.
  /// Note: Only supports integer powers for precision.
  BigNumber pow(int power) {
    if (power == 0) {
      return BigNumber(1, 0);
    }
    if (power == 1) {
      return this;
    }
    if (power < 0) {
      // For negative powers, calculate 1 / (this^abs(power))
      return BigNumber(1, 0).divide(pow(-power));
    }

    var result = this;
    for (var i = 1; i < power; i++) {
      result = result * this;
    }
    return result;
  }

  /// Formats the number as a compact string (e.g., "1.5K", "2.3M").
  String formatCompact() => format(compact: true);

  /// Formats the number in scientific notation (e.g., "1.50e12").
  String formatScientific() => format(useScientific: true);

  /// Formats the number with full precision.
  String formatFull() => format();

  /// Returns a percentage string (multiplies by 100 and adds %).
  /// Example: 0.75 -> "75%"
  String formatPercent({int decimals = 0}) {
    final percent = toDouble() * 100;
    return '${percent.toStringAsFixed(decimals)}%';
  }
}
