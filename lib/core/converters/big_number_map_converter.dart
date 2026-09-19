import 'package:idle_laboratory/core/converters/big_number_converter.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:json_annotation/json_annotation.dart';

class BigNumberStringMapConverter implements JsonConverter<Map<String, BigNumber>, Map<String, dynamic>> {
  const BigNumberStringMapConverter();

  static const _bigNumber = BigNumberConverter();

  @override
  Map<String, BigNumber> fromJson(Map<String, dynamic> json) =>
      json.map((key, value) => MapEntry(key, _bigNumber.fromJson(Map<String, dynamic>.from(value as Map))));

  @override
  Map<String, dynamic> toJson(Map<String, BigNumber> map) =>
      map.map((key, value) => MapEntry(key, _bigNumber.toJson(value)));
}
