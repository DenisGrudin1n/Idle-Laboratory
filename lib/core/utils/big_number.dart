import 'dart:math' as math;

import '../constants/game_constants.dart';

/// Represents large numbers using mantissa and exponent
/// Similar to scientific notation: mantissa * 10^exponent
/// Example: 1.5e12 is stored as mantissa=1.5, exponent=12
class BigNumber {
  BigNumber(this.mantissa, this.exponent) {
    _normalize();
  }

  factory BigNumber.fromDouble(double value) {
    if (value == 0) {
      return BigNumber(0, 0);
    }

    final int exponent = (math.log(value.abs()) / math.ln10).floor();
    final double mantissa = value / math.pow(10, exponent);

    return BigNumber(mantissa, exponent);
  }

  factory BigNumber.zero() => BigNumber(0, 0);

  double mantissa;
  int exponent;

  /// Normalizes mantissa to be between 1.0 and 10.0 (or 0)
  void _normalize() {
    if (mantissa == 0) {
      exponent = 0;
      return;
    }

    while (mantissa.abs() >= 10) {
      mantissa /= 10;
      exponent++;
    }

    while (mantissa.abs() < 1 && mantissa != 0) {
      mantissa *= 10;
      exponent--;
    }
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

  BigNumber copy() => BigNumber(mantissa, exponent);

  @override
  String toString() => format();
}
