import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/constants/crafting_layout.dart';
import 'package:idle_laboratory/core/constants/crafting_layout_metrics.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/constants/game_errors.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/widgets/amount_text_field.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/crafting/crafting_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/animated_cell_graphic.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_cell_picker_dialog.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_full_row_conduit_painter.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_input_slot.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_material_picker_dialog.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_output_slot.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_material_slot_icon.dart';

class CraftingInterfacePanel extends StatefulWidget {
  const CraftingInterfacePanel({super.key});

  @override
  State<CraftingInterfacePanel> createState() => _CraftingInterfacePanelState();
}

class _CraftingInterfacePanelState extends State<CraftingInterfacePanel> {
  late final TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    final initialQuantity = context.read<CraftingBloc>().state.targetQuantity;
    _quantityController = TextEditingController(text: initialQuantity.toString());
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  static const _cellSlotIndex = 2;
  static const _craftingEnergyCostPerUnit = 5;
  static const _craftingDuration = '00:05';
  static double get _actionButtonWidth => 104;

  Future<void> _openCellPicker(BuildContext context, CellId? current, bool isCrafting) async {
    if (isCrafting) return;
    final picked = await showCraftingCellPickerDialog(context, allowClear: current != null);
    if (!context.mounted) return;
    context.read<CraftingBloc>().add(CraftingEvent.cellSlotChanged(picked));
  }

  Future<void> _openMaterialPicker(
    BuildContext context,
    int slotIndex,
    ResearchMaterialId? current,
    bool isCrafting,
  ) async {
    if (isCrafting) return;
    final picked = await showCraftingMaterialPickerDialog(context, allowClear: current != null);
    if (!context.mounted) return;
    if (slotIndex == 0) {
      context.read<CraftingBloc>().add(CraftingEvent.reagent1Changed(picked));
    } else {
      context.read<CraftingBloc>().add(CraftingEvent.reagent2Changed(picked));
    }
  }

  Widget _buildSlotsRow({
    required BuildContext context,
    required double width,
    required CraftingLayoutMetrics metrics,
    required CraftingState state,
  }) {
    final color = context.color;
    final verticalGap = metrics.inputVerticalGap;
    final inputsH = metrics.inputsColumnHeight;
    final outputSide = metrics.outputSlotSide;
    final coreH = metrics.slotsCoreHeight;
    final inputsTop = (coreH - inputsH) / 2;
    final outputTop = (coreH - outputSide) / 2;
    final outputCenterY = outputTop + outputSide / 2;

    final outputMaterial = state.craftingMaterialId;

    return SizedBox(
      width: width,
      height: coreH,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: CraftingFullRowConduitPainter(
                  slotSide: metrics.inputSlotSide,
                  verticalGap: verticalGap,
                  inputsTop: inputsTop,
                  outputSide: outputSide,
                  outputCenterY: outputCenterY,
                  gapBeforeOutput: CraftingLayout.gapBeforeOutputSlot,
                  tubeColor: color.treeConduitTubeColor,
                  glowColor: color.treeConduitGlowColor,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: outputTop,
            child: CraftingOutputSlot(
              outputMaterialId: outputMaterial,
              slotSide: outputSide,
              onTap: outputMaterial == null || state.isCrafting
                  ? null
                  : () => context.read<CraftingBloc>().add(const CraftingEvent.startReaction()),
            ),
          ),
          Positioned(
            left: 0,
            top: inputsTop,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CraftingInputSlot(
                  slotIndex: 0,
                  slotSide: metrics.inputSlotSide,
                  selectedMaterialId: state.reagent1Id,
                  onTap: state.isCrafting
                      ? null
                      : () => _openMaterialPicker(context, 0, state.reagent1Id, state.isCrafting),
                ),
                SizedBox(height: verticalGap),
                CraftingInputSlot(
                  slotIndex: 1,
                  slotSide: metrics.inputSlotSide,
                  selectedMaterialId: state.reagent2Id,
                  onTap: state.isCrafting
                      ? null
                      : () => _openMaterialPicker(context, 1, state.reagent2Id, state.isCrafting),
                ),
                SizedBox(height: verticalGap),
                CraftingInputSlot(
                  slotIndex: _cellSlotIndex,
                  slotSide: metrics.inputSlotSide,
                  selectedCellId: state.selectedCellId,
                  onTap: state.isCrafting
                      ? null
                      : () => _openCellPicker(context, state.selectedCellId, state.isCrafting),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionColumn(BuildContext context, {required CraftingState state}) {
    final l10n = context.l10n;
    final color = context.color;

    final totalEnergyCost = _craftingEnergyCostPerUnit * state.targetQuantity;

    String? cellAmount;
    if (state.selectedCellId != null) {
      cellAmount =
          (GameBalance.calculateBaseTierResearchCraftCellCost(state.selectedCellId!.order) *
                  BigNumber(state.targetQuantity.toDouble(), 0))
              .format(compact: true);
    }

    final canStart = state.craftingMaterialId != null && !state.isCrafting && state.error == null;

    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isMobile = appVersion == AppVersionEnum.mobile;
        final buttonHeight = isMobile ? 26.0 : 32.0;

        return SizedBox(
          width: _actionButtonWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.craftingCostWithAmount('$totalEnergyCost EU'),
                style: context.styles.compactValue,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              if (cellAmount != null && state.selectedCellId != null) ...[
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        l10n.craftingCellAmount(cellAmount),
                        style: context.styles.compactAccentValue,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: CraftingLayout.actionCellIconHeight * CraftingLayout.cellGraphicAspectWidthOverHeight,
                      height: CraftingLayout.actionCellIconHeight,
                      child: AnimatedCellGraphic(cellId: state.selectedCellId!),
                    ),
                  ],
                ),
              ],
              if (state.reagent1Id != null && state.reagent2Id != null) ...[
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${state.targetQuantity}×', style: context.styles.compactAccentValue),
                    const SizedBox(width: 2),
                    SizedBox(
                      width: 10,
                      height: 10,
                      child: ResearchMaterialSlotIcon(materialId: state.reagent1Id!),
                    ),
                    const SizedBox(width: 4),
                    Text('+', style: context.styles.compactValue),
                    const SizedBox(width: 4),
                    Text('${state.targetQuantity}×', style: context.styles.compactAccentValue),
                    const SizedBox(width: 2),
                    SizedBox(
                      width: 10,
                      height: 10,
                      child: ResearchMaterialSlotIcon(materialId: state.reagent2Id!),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 2),
              Text(
                l10n.craftingTimeWithDuration(_craftingDuration),
                style: context.styles.compactValue,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: buttonHeight,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: state.isCrafting
                        ? color.accent.withValues(alpha: 0.8)
                        : (!canStart ? color.sectionBorder.withValues(alpha: 0.5) : color.green),
                    foregroundColor: color.titleText,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: Size(_actionButtonWidth, buttonHeight),
                    maximumSize: Size(_actionButtonWidth, buttonHeight),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                  ),
                  onPressed: state.isCrafting
                      ? () => context.read<CraftingBloc>().add(const CraftingEvent.stopReaction())
                      : (!canStart
                            ? null
                            : () => context.read<CraftingBloc>().add(const CraftingEvent.startReaction())),
                  child: Text(
                    state.isCrafting ? l10n.craftingStopReaction : l10n.craftingStartReaction,
                    style: context.styles.buttonLabel.copyWith(
                      color: (!canStart && !state.isCrafting)
                          ? color.titleText.withValues(alpha: 0.5)
                          : color.titleText,
                      fontSize: 10,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    state.error == GameErrors.craftingNotEnoughMaterials
                        ? l10n.craftingNotEnoughMaterials
                        : l10n.craftingNotEnoughEnergy,
                    style: context.styles.compactValue.copyWith(color: color.accent, fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      '${l10n.craftingTargetAmount}:',
                      style: context.styles.compactSupporting.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AmountTextField(
                    controller: _quantityController,
                    readOnly: state.isCrafting,
                    onChanged: (value) {
                      final q = int.tryParse(value) ?? 1;
                      context.read<CraftingBloc>().add(CraftingEvent.targetQuantityChanged(q));
                    },
                  ),
                ],
              ),
              if ((state.selectedCellId != null || state.reagent1Id != null || state.reagent2Id != null) &&
                  !state.isCrafting) ...[
                const SizedBox(height: 4),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: color.primaryText,
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    context.read<CraftingBloc>().add(const CraftingEvent.inputsCleared());
                    _quantityController.text = '1';
                  },
                  child: Text(l10n.craftingClearInputs, style: context.styles.bodyLabel.copyWith(fontSize: 10)),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;

    return BlocListener<CraftingBloc, CraftingState>(
      listenWhen: (prev, curr) => prev.targetQuantity != curr.targetQuantity,
      listener: (context, state) {
        final text = state.targetQuantity.toString();
        if (_quantityController.text != text) {
          _quantityController.text = text;
        }
      },
      child: BlocBuilder<CraftingBloc, CraftingState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //TODO: refactor 2 layers of Expanede + LayoutBuilder
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final slotsAreaWidth =
                        constraints.maxWidth - _actionButtonWidth - CraftingLayout.gapAfterOutputSlot;

                    return Row(
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, area) {
                              final metrics = CraftingLayoutMetrics.forAvailableHeight(area.maxHeight);

                              return Align(
                                alignment: Alignment.centerLeft,
                                child: _buildSlotsRow(
                                  context: context,
                                  width: slotsAreaWidth,
                                  metrics: metrics,
                                  state: state,
                                ),
                              );
                            },
                          ),
                        ),
              SizedBox(width: CraftingLayout.gapAfterOutputSlot),
              _buildActionColumn(context, state: state),
            ],
          );
        },
      ),
    ),
    const SizedBox(height: 6),
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: state.craftingProgress,
        minHeight: 5,
        backgroundColor: color.sectionBorder.withValues(alpha: 0.25),
        color: color.green.withValues(alpha: 0.85),
      ),
    ),
  ],
);
        },
      ),
    );
  }
}
