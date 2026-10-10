import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';

part 'crafting_reaction_model.freezed.dart';

/// Runtime state of the active crafting reaction (not persisted).
@freezed
abstract class CraftingReactionModel with _$CraftingReactionModel {
  const factory CraftingReactionModel({
    @Default(false) bool isCrafting,
    @Default(0) double progress,
    @Default(0) int remaining,
    ResearchMaterialId? outputId,
    CellId? cellId,
    ResearchMaterialId? reagent1Id,
    ResearchMaterialId? reagent2Id,
  }) = _CraftingReactionModel;
}
