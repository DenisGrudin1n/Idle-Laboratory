/// Log labels for fire-and-forget persistence failures (see `fireAndForget`).
class PersistenceLabels {
  const PersistenceLabels._();

  static const lifecycleFlush = 'lifecycle flush';

  static const energyAutosave = 'energy autosave';
  static const energyReset = 'energy reset save';
  static const energyDispose = 'energy dispose save';

  static const cellsAutosave = 'cells autosave';
  static const cellsReset = 'cells reset save';
  static const productionAutosave = 'production autosave';
  static const productionReset = 'production reset save';

  static const inventoryAutosave = 'inventory autosave';
  static const inventoryReset = 'inventory reset save';
  static const inventoryDispose = 'inventory dispose save';

  static const statisticsLoad = 'statistics load';
  static const statisticsSessionStart = 'statistics session start';
  static const statisticsSave = 'statistics save';
  static const statisticsAutosave = 'statistics autosave';
  static const statisticsDispose = 'statistics dispose save';
}
