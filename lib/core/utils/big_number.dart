import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:idle_laboratory/core/constants/game_constants.dart';

@immutable
class BigNumber {
  factory BigNumber(double mantissa, int exponent) {
    final (normalizedMantissa, normalizedExponent) = _normalize(mantissa, exponent);
    return BigNumber._internal(normalizedMantissa, normalizedExponent);
  }

  const BigNumber._internal(this.mantissa, this.exponent);

  factory BigNumber.fromDouble(double value) {
    if (value.isNaN || value.isInfinite) throw ArgumentError('Invalid double: $value');
    if (value == 0) return BigNumber.zero();
    final exponent = (math.log(value.abs()) / math.ln10).floor();
    return BigNumber(value / math.pow(10, exponent), exponent);
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
    if (other.mantissa == 0) return this;
    if (exponent == other.exponent) return BigNumber(mantissa + other.mantissa, exponent);
    if (exponent > other.exponent) {
      final diff = exponent - other.exponent;
      return diff > 15 ? this : BigNumber(mantissa + other.mantissa / math.pow(10, diff), exponent);
    } else {
      final diff = other.exponent - exponent;
      return diff > 15 ? other : BigNumber(other.mantissa + mantissa / math.pow(10, diff), other.exponent);
    }
  }

  BigNumber operator *(BigNumber other) => BigNumber(mantissa * other.mantissa, exponent + other.exponent);
  BigNumber multiplyByDouble(double scalar) => BigNumber(mantissa * scalar, exponent);
  BigNumber divideByDouble(double scalar) => BigNumber(mantissa / scalar, exponent);

  static BigNumber pow(double base, double exponent) {
    if (base <= 0) return BigNumber.zero();
    // base^exponent = 10^(exponent * log10(base))
    final log10Base = math.log(base) / math.ln10;
    final totalLog10 = exponent * log10Base;
    final newExponent = totalLog10.floor();
    final newMantissa = math.pow(10, totalLog10 - newExponent).toDouble();
    return BigNumber(newMantissa, newExponent);
  }

  bool operator >(BigNumber other) {
    if (mantissa < 0 != other.mantissa < 0) return mantissa >= 0;
    if (exponent != other.exponent) return mantissa < 0 ? exponent < other.exponent : exponent > other.exponent;
    return mantissa > other.mantissa;
  }

  bool operator <(BigNumber other) {
    if (mantissa < 0 != other.mantissa < 0) return mantissa < 0;
    if (exponent != other.exponent) return mantissa < 0 ? exponent > other.exponent : exponent < other.exponent;
    return mantissa < other.mantissa;
  }

  bool operator >=(BigNumber other) => this > other || this == other;
  bool operator <=(BigNumber other) => this < other || this == other;

  BigNumber operator -(BigNumber other) {
    if (mantissa == 0) return BigNumber(-other.mantissa, other.exponent);
    if (other.mantissa == 0) return this;
    if (exponent == other.exponent) return BigNumber(mantissa - other.mantissa, exponent);
    final diff = (exponent - other.exponent).abs();
    if (diff > 15) return exponent > other.exponent ? this : BigNumber(-other.mantissa, other.exponent);
    return exponent > other.exponent
        ? BigNumber(mantissa - other.mantissa * math.pow(10, other.exponent - exponent), exponent)
        : BigNumber(mantissa * math.pow(10, exponent - other.exponent) - other.mantissa, other.exponent);
  }

  @override
  bool operator ==(Object other) => other is BigNumber && mantissa == other.mantissa && exponent == other.exponent;

  @override
  int get hashCode => Object.hash(mantissa, exponent);

  double toDouble() => exponent > 308 ? double.infinity : exponent < -308 ? 0 : mantissa * math.pow(10, exponent);

  double ratio(BigNumber divisor, {double? max}) {
    if (divisor.mantissa == 0) return max ?? double.maxFinite;
    if (mantissa == 0) return 0;
    final exponentDiff = exponent - divisor.exponent;
    if (exponentDiff > 15) return max ?? double.maxFinite;
    if (exponentDiff < -15) return 0;
    final result = (mantissa / divisor.mantissa) * math.pow(10, exponentDiff);
    return !result.isFinite || result < 0 ? 0 : (max != null ? result.clamp(0.0, max) : result);
  }

  String format({bool compact = false, bool useScientific = false}) {
    if (mantissa == 0) return '0.0';
    if (useScientific) return '${mantissa.toStringAsFixed(2)}e$exponent';
    if (exponent < 0) return toDouble().toStringAsFixed(compact ? 3 : 4);
    final groupIndex = (exponent / 3).floor();
    if (groupIndex >= GameConstants.suffixes.length) return '${mantissa.toStringAsFixed(2)}e$exponent';
    final displayValue = mantissa * math.pow(10, exponent % 3);
    final decimals = compact ? 1 : 2;
    return groupIndex == 0 && displayValue < 1000 ? displayValue.toStringAsFixed(decimals) : '${displayValue.toStringAsFixed(decimals)}${GameConstants.suffixes[groupIndex]}';
  }

  @override
  String toString() => format();
}
