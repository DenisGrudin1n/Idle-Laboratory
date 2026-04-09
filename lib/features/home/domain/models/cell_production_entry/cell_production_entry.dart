import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';

class CellProductionEntry {
  const CellProductionEntry({
    required this.cellId,
    required this.amount,
    this.accelerationLevel = 1,
  });

  factory CellProductionEntry.initial(String cellId) => CellProductionEntry(
        cellId: cellId,
        amount: BigNumber.zero(),
      );

  factory CellProductionEntry.fromJson(Map<String, dynamic> json) {
    final mantissa = (json['m'] as num?)?.toDouble() ?? 0.0;
    final exponent = (json['e'] as num?)?.toInt() ?? 0;
    final level = (json['a'] as num?)?.toInt() ?? 1;
    return CellProductionEntry(
      cellId: json['i'] as String? ?? '',
      amount: BigNumber(mantissa, exponent),
      accelerationLevel: level.clamp(1, GameBalance.maxAccelerationLevel),
    );
  }

  final String cellId;
  final BigNumber amount;
  final int accelerationLevel;

  CellProductionEntry copyWith({BigNumber? amount, int? accelerationLevel}) => CellProductionEntry(
        cellId: cellId,
        amount: amount ?? this.amount,
        accelerationLevel: accelerationLevel ?? this.accelerationLevel,
      );

  Map<String, dynamic> toJson() => {
        'i': cellId,
        'm': amount.mantissa,
        'e': amount.exponent,
        'a': accelerationLevel,
      };
}
