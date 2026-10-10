import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/converters/big_number_converter.dart';
import 'package:idle_laboratory/core/converters/big_number_map_converter.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';

part 'statistics_model.freezed.dart';
part 'statistics_model.g.dart';

@freezed
abstract class StatisticsModel with _$StatisticsModel {
  const factory StatisticsModel({
    @BigNumberConverter() required BigNumber lifetimeEnergyGenerated,
    @BigNumberConverter() required BigNumber lifetimeEnergySpent,
    @BigNumberConverter() required BigNumber peakEnergy,
    @BigNumberConverter() required BigNumber peakEps,
    @BigNumberConverter() required BigNumber energyEarnedThisPrestigeRun,
    @BigNumberConverter() required BigNumber lifetimeCellsProduced,
    @BigNumberConverter() required BigNumber lifetimeCraftEnergySpent,
    @BigNumberConverter() required BigNumber highestPrestigeMultiplier,
    @BigNumberConverter() required BigNumber energyAtLastPrestige,
    @BigNumberConverter() required BigNumber bestPrestigeRunEnergy,
    @Default(0) int totalPlayTimeSeconds,
    /// Cold starts only; resuming from background is not a new session.
    @Default(0) int sessionsStarted,

    /// Longest uninterrupted foreground stretch (resets on pause/hidden/detached).
    @Default(0) int longestSessionSeconds,
    int? firstLaunchEpochMs,
    @BigNumberStringMapConverter() @Default(<String, BigNumber>{}) Map<String, BigNumber> lifetimeCellsProducedByType,
    @Default(0) int lifetimeCellLevelUps,
    @Default(0) int peakTotalCellLevels,
    @Default(0) int lifetimeProductionLevelUps,
    @Default(0) int peakTotalProductionLevels,
    @Default(0) int lifetimeCraftsCompleted,
    @Default(0) int lifetimeMaterialsCrafted,
    @Default(<String, int>{}) Map<String, int> lifetimeMaterialsCraftedByType,
    @Default(0) int lifetimeCraftDurationSeconds,
  }) = _StatisticsModel;

  const StatisticsModel._();

  factory StatisticsModel.fromJson(Map<String, dynamic> json) => _$StatisticsModelFromJson(json);

  factory StatisticsModel.initial() => StatisticsModel(
    lifetimeEnergyGenerated: BigNumber.zero(),
    lifetimeEnergySpent: BigNumber.zero(),
    peakEnergy: BigNumber.zero(),
    peakEps: BigNumber.zero(),
    energyEarnedThisPrestigeRun: BigNumber.zero(),
    lifetimeCellsProduced: BigNumber.zero(),
    lifetimeCraftEnergySpent: BigNumber.zero(),
    highestPrestigeMultiplier: BigNumber.zero(),
    energyAtLastPrestige: BigNumber.zero(),
    bestPrestigeRunEnergy: BigNumber.zero(),
  );

  /// Research tree nodes crafted at least once.
  int get researchMaterialsDiscovered => lifetimeMaterialsCraftedByType.values.where((count) => count > 0).length;

  int get researchMaterialsTotal => ResearchMaterialId.values.length;
}
