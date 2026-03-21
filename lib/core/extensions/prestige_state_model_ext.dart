import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';

extension PrestigeStateModelExt on PrestigeStateModel {
  bool get isReady => isUnlocked;
  bool get hasPrestiged => prestigeCount > 0;

  String getTotalMultiplierFormatted({bool compact = true}) => totalMultiplier.format(compact: compact);
  String getCurrentMultiplierFormatted({bool compact = true}) => currentMultiplier.format(compact: compact);
  String getThresholdFormatted({bool compact = true}) => currentThreshold.format(compact: compact);

  double getProgress(BigNumber currentEnergy) => currentThreshold <= BigNumber.zero() ? 0 : currentEnergy.ratio(currentThreshold, max: 1);

  String getProgressFormatted(BigNumber currentEnergy, {int decimals = 1}) => '${(getProgress(currentEnergy) * 100).toStringAsFixed(decimals)}%';

  BigNumber getEffectiveTotalMultiplier() => isUnlocked ? totalMultiplier + currentMultiplier : totalMultiplier;

  BigNumber getMultiplierGain() => currentMultiplier;

  bool hasSignificantGain() => currentMultiplier >= BigNumber(1, 0);
}
