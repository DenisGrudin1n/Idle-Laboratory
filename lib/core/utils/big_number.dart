import 'dart:math' as math;

import '../constants/game_constants.dart';

/// Represents large numbers using mantissa and exponent
/// Similar to scientific notation: mantissa * 10^exponent
/// Example: 1.5e12 is stored as mantissa=1.5, exponent=12
/// This class is immutable - all operations return new instances.
class BigNumber {
  factory BigNumber(double mantissa, int exponent) {
    final (double normalizedMantissa, int normalizedExponent) = _normalize(
      mantissa,
      exponent,
    );
    return BigNumber._internal(normalizedMantissa, normalizedExponent);
  }

  const BigNumber._internal(this.mantissa, this.exponent);

  factory BigNumber.fromDouble(double value) {
    // Handle special double values
    if (value.isNaN || value.isInfinite) {
      throw ArgumentError(
        'Cannot create BigNumber from ${value.isNaN ? "NaN" : "Infinity"}',
      );
    }

    if (value == 0) {
      return BigNumber.zero();
    }

    final int exponent = (math.log(value.abs()) / math.ln10).floor();
    final double mantissa = value / math.pow(10, exponent);

    return BigNumber(mantissa, exponent);
  }

  factory BigNumber.zero() => const BigNumber._internal(0.0, 0);

  final double mantissa;
  final int exponent;

  /// Normalizes mantissa to be between 1.0 and 10.0 (or 0)
  /// Returns a record with (mantissa, exponent)
  static (double, int) _normalize(double mantissa, int exponent) {
    if (mantissa == 0) {
      return (0.0, 0);
    }

    double m = mantissa;
    int e = exponent;

    while (m.abs() >= 10) {
      m /= 10;
      e++;
    }

    while (m.abs() < 1 && m != 0) {
      m *= 10;
      e--;
    }

    return (m, e);
  }

  BigNumber operator +(BigNumber other) {
    if (mantissa == 0) {
      return BigNumber(other.mantissa, other.exponent);
    }
    if (other.mantissa == 0) {
      return BigNumber(mantissa, exponent);
    }

    // Align exponents
    if (exponent == other.exponent) {
      return BigNumber(mantissa + other.mantissa, exponent);
    }

    // Use the larger exponent
    if (exponent > other.exponent) {
      final int diff = exponent - other.exponent;
      if (diff > 15) {
        return BigNumber(mantissa, exponent); // Other number too small
      }
      final double adjustedOther = other.mantissa / math.pow(10, diff);
      return BigNumber(mantissa + adjustedOther, exponent);
    } else {
      final int diff = other.exponent - exponent;
      if (diff > 15) {
        return BigNumber(
          other.mantissa,
          other.exponent,
        ); // This number too small
      }
      final double adjustedThis = mantissa / math.pow(10, diff);
      return BigNumber(other.mantissa + adjustedThis, other.exponent);
    }
  }

  BigNumber operator *(BigNumber other) {
    return BigNumber(mantissa * other.mantissa, exponent + other.exponent);
  }

  BigNumber multiplyByDouble(double scalar) {
    return BigNumber(mantissa * scalar, exponent);
  }

  bool operator >(BigNumber other) {
    // Handle signs first
    final bool thisIsNegative = mantissa < 0;
    final bool otherIsNegative = other.mantissa < 0;

    if (thisIsNegative != otherIsNegative) {
      return !thisIsNegative; // Positive is always greater than negative
    }

    // Both have the same sign
    if (exponent != other.exponent) {
      if (thisIsNegative) {
        return exponent <
            other.exponent; // For negatives, smaller exponent is greater
      }
      return exponent > other.exponent;
    }
    return mantissa > other.mantissa;
  }

  bool operator <(BigNumber other) {
    // Handle signs first
    final bool thisIsNegative = mantissa < 0;
    final bool otherIsNegative = other.mantissa < 0;

    if (thisIsNegative != otherIsNegative) {
      return thisIsNegative; // Negative is always less than positive
    }

    // Both have the same sign
    if (exponent != other.exponent) {
      if (thisIsNegative) {
        return exponent >
            other.exponent; // For negatives, larger exponent is smaller
      }
      return exponent < other.exponent;
    }
    return mantissa < other.mantissa;
  }

  bool operator >=(BigNumber other) => this > other || this == other;

  bool operator <=(BigNumber other) => this < other || this == other;

  BigNumber operator -(BigNumber other) {
    // Convert to same exponent for subtraction
    if (mantissa == 0) {
      return BigNumber(-other.mantissa, other.exponent);
    }
    if (other.mantissa == 0) {
      return this;
    }

    // Align exponents
    if (exponent == other.exponent) {
      return BigNumber(mantissa - other.mantissa, exponent);
    }

    // Check for precision loss with large exponent differences
    final int expDiff = (exponent - other.exponent).abs();
    if (expDiff > 15) {
      // If the difference is too large, return the larger number
      // (the smaller one is negligible)
      return exponent > other.exponent
          ? this
          : BigNumber(-other.mantissa, other.exponent);
    }

    // Use the larger exponent
    if (exponent > other.exponent) {
      final double adjustedOther =
          other.mantissa * math.pow(10, other.exponent - exponent);
      return BigNumber(mantissa - adjustedOther, exponent);
    } else {
      final double adjustedThis =
          mantissa * math.pow(10, exponent - other.exponent);
      return BigNumber(adjustedThis - other.mantissa, other.exponent);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! BigNumber) {
      return false;
    }
    return mantissa == other.mantissa && exponent == other.exponent;
  }

  @override
  int get hashCode => Object.hash(mantissa, exponent);

  /// Converts to double (may lose precision for very large numbers)
  double toDouble() {
    if (exponent > 308) {
      return double.infinity;
    }
    if (exponent < -308) {
      return 0.0;
    }
    return mantissa * math.pow(10, exponent);
  }

  /// Calculates the ratio of this number to another as a double (0.0 to infinity)
  /// Designed for calculating percentages and fill levels without precision loss
  /// Returns a finite value suitable for UI display (e.g., 0.0 to 1.0 for progress)
  ///
  /// If [max] is provided, the result will be clamped to [0.0, max].
  /// This is useful for UI scenarios where you need a bounded ratio (e.g., progress bars).
  double ratio(BigNumber divisor, {double? max}) {
    // Handle zero cases
    // Handle zero divisor: return a safe finite value instead of NaN
    if (divisor.mantissa == 0) {
      // If clamping is enabled, treat this as an "infinite" ratio capped at max.
      // Otherwise return a large finite value suitable for UI.
      return max ?? double.maxFinite;
    }
    if (mantissa == 0) {
      return 0.0;
    }

    // Calculate exponent difference
    final int expDiff = exponent - divisor.exponent;

    // If the dividend is much larger than divisor
    if (expDiff > 15) {
      // Return max if clamping is enabled, otherwise return a large finite value
      return max ?? double.maxFinite;
    }

    // If the dividend is much smaller than divisor, return 0.0
    if (expDiff < -15) {
      return 0.0; // Very small ratio, essentially zero
    }

    // Perform division in mantissa space with exponent adjustment
    final double result = (mantissa / divisor.mantissa) * math.pow(10, expDiff);

    // Safety check for invalid results
    if (!result.isFinite || result < 0) {
      return 0.0;
    }

    // Apply clamping if max is provided
    return max != null ? result.clamp(0.0, max) : result;
  }

  /// Formats the number with suffix notation
  String format({bool compact = false, bool useScientific = false}) {
    if (mantissa == 0) {
      return '0.0';
    }

    // Use scientific notation if requested
    if (useScientific) {
      return '${mantissa.toStringAsFixed(2)}e$exponent';
    }

    // Handle numbers less than 1.0 (negative exponents)
    if (exponent < 0) {
      final double value = toDouble();
      return value.toStringAsFixed(compact ? 3 : 4);
    }

    // Group into thousands (K, M, B, T, etc.)
    final int groupIndex = (exponent / 3).floor();

    if (groupIndex >= GameConstants.suffixes.length) {
      // Fallback to scientific notation
      return '${mantissa.toStringAsFixed(2)}e$exponent';
    }

    // Calculate display value
    final int remainderExp = exponent % 3;
    final double displayValue = mantissa * math.pow(10, remainderExp);
    final int decimals = compact ? 1 : 2;

    if (groupIndex == 0 && displayValue < 1000) {
      return displayValue.toStringAsFixed(decimals);
    }

    return '${displayValue.toStringAsFixed(decimals)}${GameConstants.suffixes[groupIndex]}';
  }

  BigNumber copy() => BigNumber._internal(mantissa, exponent);

  @override
  String toString() => format();
}
