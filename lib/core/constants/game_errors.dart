class GameErrors {
  const GameErrors._();

  static const String craftingNotEnoughMaterials = 'crafting_not_enough_materials';
  static const String craftingNotEnoughEnergy = 'crafting_not_enough_energy';

  static const String cellAlreadyUnlocked = 'cell_already_unlocked';
  static const String cellLocked = 'cell_locked';
  static const String cellMaxLevel = 'cell_max_level';
  static const String cellNoUnlockRequirement = 'cell_no_unlock_requirement';
  static const String cellNoLevelUpRequirement = 'cell_no_level_up_requirement';
  static const String insufficientEnergy = 'insufficient_energy';

  static const String prestigeLocked = 'prestige_locked';
  static const String prestigeGainTooLow = 'prestige_gain_too_low';

  static const String energyNegative = 'energy_negative';
  static const String energyNaN = 'energy_nan';
  static const String energyInfinite = 'energy_infinite';

  static const String levelNegative = 'level_negative';
  static const String levelExceedsMaximum = 'level_exceeds_maximum';
}
