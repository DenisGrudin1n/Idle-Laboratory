import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/constants/crafting_layout.dart';
import 'package:idle_laboratory/core/constants/crafting_layout_metrics.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/research_material_l10n_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/crafting/crafting_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/animated_cell_graphic.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_cell_picker_dialog.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_full_row_conduit_painter.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_input_slot.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_output_slot.dart';

class CraftingInterfacePanel extends StatelessWidget {
  const CraftingInterfacePanel({super.key});

  static const _cellSlotIndex = 2;
  static const _placeholderCost = '— EU';
  static const _placeholderDuration = '00:30';
  static double get _actionButtonWidth => 104.w;

  Future<void> _openCellPicker(BuildContext context, CellId? current) async {
    final picked = await showCraftingCellPickerDialog(context, allowClear: current != null);
    if (!context.mounted) return;
    context.read<CraftingBloc>().add(CraftingEvent.cellSlotChanged(picked));
  }

  Widget _buildSlotsRow({
    required BuildContext context,
    required double width,
    required CraftingLayoutMetrics metrics,
    required CellId? selectedCellId,
    required ResearchMaterialId? outputMaterial,
  }) {
    final color = context.color;
    final verticalGap = metrics.inputVerticalGap;
    final inputsH = metrics.inputsColumnHeight;
    final outputSide = metrics.outputSlotSide;
    final coreH = metrics.slotsCoreHeight;
    final inputsTop = (coreH - inputsH) / 2;
    final outputTop = (coreH - outputSide) / 2;
    final outputCenterY = outputTop + outputSide / 2;
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
            child: IgnorePointer(
              child: CraftingOutputSlot(outputMaterialId: outputMaterial, slotSide: outputSide),
            ),
          ),
          Positioned(
            left: 0,
            top: inputsTop,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CraftingInputSlot(slotIndex: 0, slotSide: metrics.inputSlotSide),
                SizedBox(height: verticalGap),
                CraftingInputSlot(slotIndex: 1, slotSide: metrics.inputSlotSide),
                SizedBox(height: verticalGap),
                CraftingInputSlot(
                  slotIndex: _cellSlotIndex,
                  slotSide: metrics.inputSlotSide,
                  selectedCellId: selectedCellId,
                  onTap: () => _openCellPicker(context, selectedCellId),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionColumn(
    BuildContext context, {
    required CellId? selectedCellId,
    required bool hasCell,
  }) {
    final l10n = context.l10n;
    final color = context.color;
    final cellAmount = selectedCellId == null
        ? null
        : GameBalance.calculateBaseTierResearchCraftCellCost(selectedCellId.order).format(compact: true);

    return SizedBox(
      width: _actionButtonWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.craftingCostWithAmount(_placeholderCost),
            style: context.styles.compactValue,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          if (cellAmount != null && selectedCellId != null) ...[
            SizedBox(height: 4.h),
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
                SizedBox(width: 4.w),
                SizedBox(
                  width: CraftingLayout.actionCellIconHeight * CraftingLayout.cellGraphicAspectWidthOverHeight,
                  height: CraftingLayout.actionCellIconHeight,
                  child: AnimatedCellGraphic(cellId: selectedCellId),
                ),
              ],
            ),
          ],
          SizedBox(height: 4.h),
          Text(
            l10n.craftingTimeWithDuration(_placeholderDuration),
            style: context.styles.compactValue,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 26.h,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: color.green,
                foregroundColor: color.titleText,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                minimumSize: Size(_actionButtonWidth, 26.h),
                maximumSize: Size(_actionButtonWidth, 26.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
              ),
              onPressed: () {},
              child: Text(
                l10n.craftingStartReaction,
                style: context.styles.buttonLabel.copyWith(color: color.titleText, fontSize: 10.sp),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (hasCell) ...[
            SizedBox(height: 8.h),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: color.primaryText,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () => context.read<CraftingBloc>().add(const CraftingEvent.inputsCleared()),
              child: Text(
                l10n.craftingClearInputs,
                style: context.styles.bodyLabel.copyWith(fontSize: 11.sp),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;

    return BlocBuilder<CraftingBloc, CraftingState>(
      builder: (context, state) {
        final selectedCellId = state.selectedCellId;
        final outputMaterial = selectedCellId?.baseResearchMaterial;
        final hasCell = selectedCellId != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final slotsAreaWidth = constraints.maxWidth - _actionButtonWidth - CraftingLayout.gapAfterOutputSlot;

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
                                selectedCellId: selectedCellId,
                                outputMaterial: outputMaterial,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: CraftingLayout.gapAfterOutputSlot),
                      _buildActionColumn(
                        context,
                        selectedCellId: selectedCellId,
                        hasCell: hasCell,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 6.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: LinearProgressIndicator(
                value: 0,
                minHeight: 5.h,
                backgroundColor: color.sectionBorder.withValues(alpha: 0.25),
                color: color.primary.withValues(alpha: 0.65),
              ),
            ),
          ],
        );
      },
    );
  }
}
