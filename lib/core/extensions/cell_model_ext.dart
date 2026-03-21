import 'package:idle_laboratory/core/constants/cell_level_constants.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/extensions/cell_level_extensions.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_level_model/cell_level_model.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';

extension CellModelExt on CellModel {
  CellId? get cellId => CellId.fromString(id);

  List<CellLevelModel> get levelConfigs {
    final id = cellId;
    return id == null ? [] : CellLevelConstants.getLevelConfigs(id);
  }

  CellLevelModel? get currentLevelConfig => levelConfigs.getConfig(level);
  CellLevelModel? get nextLevelConfig => levelConfigs.getConfig(level + 1);
  bool get isMaxLevel => nextLevelConfig == null;

  BigNumber? get unlockRequirement {
    final id = cellId;
    return id == null ? null : CellLevelConstants.cellUnlockRequirements[id];
  }

  BigNumber? get nextLevelEnergyRequired => nextLevelConfig?.energyRequired;
  BigNumber? get currentLevelEnergyRequired => currentLevelConfig?.energyRequired;

  bool canUnlock(BigNumber availableEnergy) {
    if (!isLocked) return false;
    final requirement = unlockRequirement;
    return requirement != null && availableEnergy >= requirement;
  }

  bool canLevelUp(BigNumber availableEnergy) {
    if (isLocked || isMaxLevel) return false;
    final requirement = nextLevelEnergyRequired;
    return requirement != null && availableEnergy >= requirement;
  }

  BigNumber get eps {
    if (isLocked) return BigNumber.zero();
    final id = cellId;
    return id == null ? BigNumber.zero() : CellEnergyPerSecond.getEPS(id, level);
  }

  BigNumber get nextLevelEPS {
    if (isLocked || isMaxLevel) return BigNumber.zero();
    final id = cellId;
    return id == null ? BigNumber.zero() : CellEnergyPerSecond.getEPS(id, level + 1);
  }

  double getProgressToNextLevel(BigNumber currentEnergy) {
    if (isLocked || isMaxLevel) return 0;
    final currentReq = currentLevelEnergyRequired;
    final nextReq = nextLevelEnergyRequired;
    if (currentReq == null || nextReq == null || currentEnergy < currentReq) return 0;
    if (currentEnergy >= nextReq) return 1;
    return (currentEnergy - currentReq).ratio(nextReq - currentReq, max: 1);
  }

  String getUnlockRequirementFormatted({bool compact = true}) => unlockRequirement?.format(compact: compact) ?? '???';
}
