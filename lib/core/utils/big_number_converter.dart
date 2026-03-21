import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:json_annotation/json_annotation.dart';

class BigNumberConverter implements JsonConverter<BigNumber, Map<String, dynamic>> {
  const BigNumberConverter();

  @override
  BigNumber fromJson(Map<String, dynamic> json) => BigNumber((json['mantissa'] as num).toDouble(), json['exponent'] as int);

  @override
  Map<String, dynamic> toJson(BigNumber bigNumber) => {
        'mantissa': bigNumber.mantissa,
        'exponent': bigNumber.exponent,
      };
}
