import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/constants/crafting_layout.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_full_row_conduit_painter.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_input_slot.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_output_slot.dart';

class CraftingInterfacePanel extends StatelessWidget {
  const CraftingInterfacePanel({super.key});

  static const _placeholderCost = '— EU';
  static const _placeholderDuration = '00:30';

  static double get _actionButtonWidth => 104.w;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = context.color;
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = CraftingLayout.maxCraftingBlockWidth(constraints.maxWidth);
        final rowH = CraftingLayout.inputsColumnHeight;
        final outputSide = rowH;
        final slotSide = CraftingLayout.inputSlotSide;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxW),
                        child: LayoutBuilder(
                          builder: (context, inner) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: inner.maxWidth,
                                height: rowH,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned.fill(
                                      child: IgnorePointer(
                                        child: CustomPaint(
                                          painter: CraftingFullRowConduitPainter(
                                            slotSide: slotSide,
                                            verticalGap: CraftingLayout.inputVerticalGap,
                                            gapBeforeOutput: CraftingLayout.gapBeforeOutputSlot,
                                            outputSide: outputSide,
                                            tubeColor: color.treeConduitTubeColor,
                                            glowColor: color.treeConduitGlowColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const CraftingInputSlot(),
                                            SizedBox(height: CraftingLayout.inputVerticalGap),
                                            const CraftingInputSlot(),
                                            SizedBox(height: CraftingLayout.inputVerticalGap),
                                            const CraftingInputSlot(),
                                          ],
                                        ),
                                        SizedBox(width: CraftingLayout.gapAfterInputSlots),
                                        const Expanded(child: SizedBox()),
                                        SizedBox(width: CraftingLayout.gapBeforeOutputSlot),
                                        SizedBox(width: outputSide, height: rowH, child: const CraftingOutputSlot()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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
              ),
            ),
            SizedBox(width: 12.w),
            Align(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: _actionButtonWidth,
                    child: Text(
                      l10n.craftingCostWithAmount(_placeholderCost),
                      style: context.styles.compactValue.copyWith(
                        color: color.primaryText.withValues(alpha: 0.8),
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: _actionButtonWidth,
                    child: Text(
                      l10n.craftingTimeWithDuration(_placeholderDuration),
                      style: context.styles.helperText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: _actionButtonWidth,
                    height: 30.h,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: color.green,
                        foregroundColor: color.titleText,
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        minimumSize: Size(_actionButtonWidth, 30.h),
                        maximumSize: Size(_actionButtonWidth, 30.h),
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
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: _actionButtonWidth,
                    height: 30.h,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: color.primaryText,
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        minimumSize: Size(_actionButtonWidth, 30.h),
                        maximumSize: Size(_actionButtonWidth, 30.h),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: BorderSide(color: color.sectionBorder.withValues(alpha: 0.85), width: 1.w),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
                      ),
                      onPressed: () {},
                      child: Text(
                        l10n.craftingClearInputs,
                        style: context.styles.buttonLabel.copyWith(fontSize: 10.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
