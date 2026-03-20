import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/utils/big_number_converter.dart';

part 'prestige_state_model.freezed.dart';
part 'prestige_state_model.g.dart';

@freezed
abstract class PrestigeStateModel with _$PrestigeStateModel {
  const factory PrestigeStateModel({
    @BigNumberConverter() required BigNumber totalMultiplier,
    @BigNumberConverter() required BigNumber currentThreshold,
    @BigNumberConverter() required BigNumber currentMultiplier,
    required bool isUnlocked,
    required int prestigeCount,
  }) = _PrestigeStateModel;

  factory PrestigeStateModel.fromJson(Map<String, dynamic> json) => _$PrestigeStateModelFromJson(json);

  factory PrestigeStateModel.initial() => PrestigeStateModel(
        totalMultiplier: BigNumber(1, 0),
        currentThreshold: BigNumber(1, 2),
        currentMultiplier: BigNumber.zero(),
        isUnlocked: false,
        prestigeCount: 0,
      );
}
