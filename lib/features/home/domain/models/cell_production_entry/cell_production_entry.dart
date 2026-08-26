import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';

part 'cell_production_entry.freezed.dart';

@Freezed(fromJson: false, toJson: false)
abstract class CellProductionEntry with _$CellProductionEntry {
  const factory CellProductionEntry({
    required String cellId,
    required BigNumber amount,
    @Default(1) int accelerationLevel,
  }) = _CellProductionEntry;

  const CellProductionEntry._();

  factory CellProductionEntry.initial(String cellId) => CellProductionEntry(
        cellId: cellId,
        amount: BigNumber.zero(),
      );

  /// Compact persisted format: `{ "i" ` cell id, ` "m" `/` "e" ` amount, ` "a" ` level.
  factory CellProductionEntry.fromJson(Map<String, dynamic> json) {
    final level = (json['a'] as num?)?.toInt() ?? 1;
    return CellProductionEntry(
      cellId: json['i'] as String? ?? '',
      amount: BigNumber(
        (json['m'] as num?)?.toDouble() ?? 0.0,
        (json['e'] as num?)?.toInt() ?? 0,
      ),
      accelerationLevel: level.clamp(1, GameBalance.maxAccelerationLevel),
    );
  }

  Map<String, dynamic> toJson() => {
        'i': cellId,
        'm': amount.mantissa,
        'e': amount.exponent,
        'a': accelerationLevel,
      };
}
