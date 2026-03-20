import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:idle_laboratory/core/constants/game_constants.dart';

@immutable
class BigNumber {
  factory BigNumber(double mantissa, int exponent) {
    final (normalizedMantissa, normalizedExponent) = _normalize(
      mantissa,
      exponent,
    );
    return BigNumber._internal(normalizedMantissa, normalizedExponent);
  }

  const BigNumber._internal(this.mantissa, this.exponent);

  factory BigNumber.fromDouble(double value) {
    if (value.isNaN || value.isInfinite) {
      throw ArgumentError(
        'Cannot create BigNumber from ${value.isNaN ? "NaN" : "Infinity"}',
      );
    }
    if (value == 0) return BigNumber.zero();
    final exponent = (math.log(value.abs()) / math.ln10).floor();
    final mantissa = value / math.pow(10, exponent);
    return BigNumber(mantissa, exponent);
  }

  factory BigNumber.zero() => const BigNumber._internal(0, 0);

  final double mantissa;
  final int exponent;

  static (double, int) _normalize(double mantissa, int exponent) {
    if (mantissa == 0) return (0.0, 0);
    var m = mantissa;
    var e = exponent;
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
    if (mantissa == 0) return BigNumber(other.mantissa, other.exponent);
    if (other.mantissa == 0) return BigNumber(mantissa, exponent);
    if (exponent == other.exponent)
      return BigNumber(mantissa + other.mantissa, exponent);

    if (exponent > other.exponent) {
      final diff = exponent - other.exponent;
      if (diff > 15) return BigNumber(mantissa, exponent);
      final adjustedOther = other.mantissa / math.pow(10, diff);
      return BigNumber(mantissa + adjustedOther, exponent);
    } else {
      final diff = other.exponent - exponent;
      if (diff > 15) return BigNumber(other.mantissa, other.exponent);
      final adjustedThis = mantissa / math.pow(10, diff);
      return BigNumber(other.mantissa + adjustedThis, other.exponent);
    }
  }

  BigNumber operator *(BigNumber other) =>
      BigNumber(mantissa * other.mantissa, exponent + other.exponent);

  BigNumber multiplyByDouble(double scalar) =>
      BigNumber(mantissa * scalar, exponent);

  bool operator >(BigNumber other) {
    final thisIsNegative = mantissa < 0;
    final otherIsNegative = other.mantissa < 0;
    if (thisIsNegative != otherIsNegative) return !thisIsNegative;
    if (exponent != other.exponent)
      return thisIsNegative
          ? exponent < other.exponent
          : exponent > other.exponent;
    return mantissa > other.mantissa;
  }

  bool operator <(BigNumber other) {
    final thisIsNegative = mantissa < 0;
    final otherIsNegative = other.mantissa < 0;
    if (thisIsNegative != otherIsNegative) return thisIsNegative;
    if (exponent != other.exponent)
      return thisIsNegative
          ? exponent > other.exponent
          : exponent < other.exponent;
    return mantissa < other.mantissa;
  }

  bool operator >=(BigNumber other) => this > other || this == other;
  bool operator <=(BigNumber other) => this < other || this == other;

  BigNumber operator -(BigNumber other) {
    if (mantissa == 0) return BigNumber(-other.mantissa, other.exponent);
    if (other.mantissa == 0) return this;
    if (exponent == other.exponent)
      return BigNumber(mantissa - other.mantissa, exponent);

    final expDiff = (exponent - other.exponent).abs();
    if (expDiff > 15)
      return exponent > other.exponent
          ? this
          : BigNumber(-other.mantissa, other.exponent);

    if (exponent > other.exponent) {
      final adjustedOther =
          other.mantissa * math.pow(10, other.exponent - exponent);
      return BigNumber(mantissa - adjustedOther, exponent);
    } else {
      final adjustedThis = mantissa * math.pow(10, exponent - other.exponent);
      return BigNumber(adjustedThis - other.mantissa, other.exponent);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BigNumber) return false;
    return mantissa == other.mantissa && exponent == other.exponent;
  }

  @override
  int get hashCode => Object.hash(mantissa, exponent);

  double toDouble() {
    if (exponent > 308) return double.infinity;
    if (exponent < -308) return 0;
    return mantissa * math.pow(10, exponent);
  }

  double ratio(BigNumber divisor, {double? max}) {
    if (divisor.mantissa == 0) return max ?? double.maxFinite;
    if (mantissa == 0) return 0;
    final expDiff = exponent - divisor.exponent;
    if (expDiff > 15) return max ?? double.maxFinite;
    if (expDiff < -15) return 0;
    final result = (mantissa / divisor.mantissa) * math.pow(10, expDiff);
    if (!result.isFinite || result < 0) return 0;
    return max != null ? result.clamp(0.0, max) : result;
  }

  String format({bool compact = false, bool useScientific = false}) {
    if (mantissa == 0) return '0.0';
    if (useScientific) return '${mantissa.toStringAsFixed(2)}e$exponent';
    if (exponent < 0) return toDouble().toStringAsFixed(compact ? 3 : 4);

    final groupIndex = (exponent / 3).floor();
    if (groupIndex >= GameConstants.suffixes.length)
      return '${mantissa.toStringAsFixed(2)}e$exponent';

    final displayValue = mantissa * math.pow(10, exponent % 3);
    final decimals = compact ? 1 : 2;
    if (groupIndex == 0 && displayValue < 1000)
      return displayValue.toStringAsFixed(decimals);
    return '${displayValue.toStringAsFixed(decimals)}${GameConstants.suffixes[groupIndex]}';
  }

  BigNumber copy() => BigNumber._internal(mantissa, exponent);

  @override
  String toString() => format();
}
