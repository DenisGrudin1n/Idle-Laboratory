import 'dart:async';

import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/constants/game_errors.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/research_material_l10n_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/utils/research_material_tree.dart';
import 'package:idle_laboratory/features/home/domain/models/crafting_reaction_model/crafting_reaction_model.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/statistics_service.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

/// Owns crafting recipes, affordability checks and the reaction loop
/// (timer, resource spending, output, statistics).
@lazySingleton
class CraftingService {
  CraftingService(this._cellsService, this._energyService, this._storageService, this._statisticsService);

  final CellsService _cellsService;
  final EnergyService _energyService;
  final StorageService _storageService;
  final StatisticsService _statisticsService;

  final BehaviorSubject<CraftingReactionModel> _reactionSubject = BehaviorSubject<CraftingReactionModel>.seeded(
    const CraftingReactionModel(),
  );
  Timer? _tickTimer;

  static final _energyCostPerUnit = BigNumber(GameBalance.craftingEnergyCostPerUnit.toDouble(), 0);
  static const _progressPerTick = GameBalance.craftingTickIntervalMs / 1000 / GameBalance.craftingDurationSeconds;

  Stream<CraftingReactionModel> get reaction$ => _reactionSubject.stream.distinct();
  CraftingReactionModel get currentReaction => _reactionSubject.value;

  /// Fires when energy, cell stock or inventory change, so callers can re-run [validate].
  Stream<void> get resourcesChanged$ => Rx.merge<Object?>([
        _cellsService.production$,
        _energyService.energy$,
        _storageService.inventory$,
      ]).map((_) {});

  ResearchMaterialId? outputFor({CellId? cellId, ResearchMaterialId? reagent1Id, ResearchMaterialId? reagent2Id}) {
    if (cellId != null) return cellId.baseResearchMaterial;
    if (reagent1Id == null || reagent2Id == null) return null;
    final p1 = ResearchMaterialTree.parentIndex(reagent1Id.index);
    final p2 = ResearchMaterialTree.parentIndex(reagent2Id.index);
    if (p1 == null || p1 != p2) return null;
    return ResearchMaterialId.values[p1];
  }

  /// Returns a [GameErrors] code when a batch of [quantity] cannot be afforded,
  /// or `null` when affordable / inputs incomplete.
  String? validate({
    required int quantity,
    CellId? cellId,
    ResearchMaterialId? reagent1Id,
    ResearchMaterialId? reagent2Id,
  }) {
    final output = outputFor(cellId: cellId, reagent1Id: reagent1Id, reagent2Id: reagent2Id);
    if (output == null) return null;
    return _missingResources(quantity: quantity, cellId: cellId, reagent1Id: reagent1Id, reagent2Id: reagent2Id);
  }

  /// Starts a reaction for [quantity] units. Inputs are spent per unit on completion.
  bool start({
    required int quantity,
    CellId? cellId,
    ResearchMaterialId? reagent1Id,
    ResearchMaterialId? reagent2Id,
  }) {
    if (currentReaction.isCrafting || quantity <= 0) return false;
    final output = outputFor(cellId: cellId, reagent1Id: reagent1Id, reagent2Id: reagent2Id);
    if (output == null) return false;
    if (validate(quantity: quantity, cellId: cellId, reagent1Id: reagent1Id, reagent2Id: reagent2Id) != null) {
      return false;
    }

    _reactionSubject.add(
      CraftingReactionModel(
        isCrafting: true,
        remaining: quantity,
        outputId: output,
        cellId: cellId,
        reagent1Id: reagent1Id,
        reagent2Id: reagent2Id,
      ),
    );
    _startTimer();
    return true;
  }

  void stop() {
    _stopTimer();
    final reaction = currentReaction;
    if (!reaction.isCrafting) return;
    _reactionSubject.add(reaction.copyWith(isCrafting: false, progress: 0));
  }

  void _startTimer() {
    _tickTimer?.cancel();
    _tickTimer = Timer.periodic(const Duration(milliseconds: GameBalance.craftingTickIntervalMs), (_) => _tick());
  }

  void _stopTimer() {
    _tickTimer?.cancel();
    _tickTimer = null;
  }

  void _tick() {
    final reaction = currentReaction;
    final output = reaction.outputId;
    if (!reaction.isCrafting || output == null) {
      _stopTimer();
      return;
    }

    final progress = reaction.progress + _progressPerTick;
    if (progress < 1) {
      _reactionSubject.add(reaction.copyWith(progress: progress));
      return;
    }

    if (!_canAffordOneUnit(reaction)) {
      stop();
      return;
    }

    _spendOneUnit(reaction);
    _storageService.addMaterial(output);
    _statisticsService.recordCraftCompleted(
      materialId: output,
      energySpent: _energyCostPerUnit,
      durationSeconds: GameBalance.craftingDurationSeconds,
    );

    final remaining = reaction.remaining - 1;
    if (remaining <= 0) {
      _stopTimer();
      _reactionSubject.add(const CraftingReactionModel());
      return;
    }

    final next = reaction.copyWith(remaining: remaining, progress: 0);
    if (_canAffordOneUnit(next)) {
      _reactionSubject.add(next);
    } else {
      _stopTimer();
      _reactionSubject.add(next.copyWith(isCrafting: false));
    }
  }

  bool _canAffordOneUnit(CraftingReactionModel reaction) =>
      _missingResources(
        quantity: 1,
        cellId: reaction.cellId,
        reagent1Id: reaction.reagent1Id,
        reagent2Id: reaction.reagent2Id,
      ) ==
      null;

  String? _missingResources({
    required int quantity,
    CellId? cellId,
    ResearchMaterialId? reagent1Id,
    ResearchMaterialId? reagent2Id,
  }) {
    final batch = BigNumber(quantity.toDouble(), 0);
    if (_energyService.currentEnergy < _energyCostPerUnit * batch) {
      return GameErrors.craftingNotEnoughEnergy;
    }

    if (cellId != null) {
      final cellCost = GameBalance.calculateBaseTierResearchCraftCellCost(cellId.order) * batch;
      final available = _cellsService.currentProduction[cellId.id]?.amount ?? BigNumber.zero();
      return available < cellCost ? GameErrors.craftingNotEnoughMaterials : null;
    }

    if (reagent1Id != null && reagent2Id != null) {
      final hasReagents = reagent1Id == reagent2Id
          ? _storageService.hasMaterial(reagent1Id, count: quantity * 2)
          : _storageService.hasMaterial(reagent1Id, count: quantity) &&
              _storageService.hasMaterial(reagent2Id, count: quantity);
      return hasReagents ? null : GameErrors.craftingNotEnoughMaterials;
    }

    return null;
  }

  void _spendOneUnit(CraftingReactionModel reaction) {
    _energyService.trySpendEnergy(_energyCostPerUnit);
    final cellId = reaction.cellId;
    final reagent1Id = reaction.reagent1Id;
    final reagent2Id = reaction.reagent2Id;
    if (cellId != null) {
      _cellsService.trySpendCells(cellId, GameBalance.calculateBaseTierResearchCraftCellCost(cellId.order));
    } else if (reagent1Id != null && reagent2Id != null) {
      _storageService
        ..trySpendMaterial(reagent1Id)
        ..trySpendMaterial(reagent2Id);
    }
  }

  @disposeMethod
  void dispose() {
    _stopTimer();
    _reactionSubject.close();
  }
}
