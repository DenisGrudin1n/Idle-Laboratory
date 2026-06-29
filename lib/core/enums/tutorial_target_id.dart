enum TutorialTargetId {
  welcome('welcome'),
  energy('energy'),
  mainNav('main_nav'),
  topNav('top_nav'),
  cellsList('cells_list'),
  prestige('prestige'),
  productionCell('production_cell'),
  craftingContainer('crafting_container'),
  craftingCellSlot('crafting_cell_slot'),
  craftingMaterialSlots('crafting_material_slots'),
  craftingOutputSlot('crafting_output_slot'),
  craftingInfoRow('crafting_info_row'),
  storageContainer('storage_container'),
  researchTree('research_tree'),
  researchGoal('research_goal');

  const TutorialTargetId(this.id);
  final String id;

  static TutorialTargetId? fromString(String id) {
    for (final targetId in TutorialTargetId.values) if (targetId.id == id) return targetId;
    return null;
  }
}
