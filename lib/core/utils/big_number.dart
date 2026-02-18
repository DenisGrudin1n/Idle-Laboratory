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
    return mantissa * math.pow(10, exponent);
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
