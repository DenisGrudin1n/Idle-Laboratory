import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/constants/crafting_layout.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_slot_frame.dart';

class CraftingOutputSlot extends StatelessWidget {
  const CraftingOutputSlot({super.key});

  @override
  Widget build(BuildContext context) {
    final side = CraftingLayout.inputsColumnHeight;
    return SizedBox(
      width: side,
      height: side,
      child: CraftingSlotFrame(
        emphasized: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.l10n.craftingMainOutputSlot,
                style: context.styles.compactSupporting.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              SizedBox(height: 4.h),
              Text(
                context.l10n.craftingSlotEmpty,
                style: context.styles.compactValue.copyWith(
                  color: context.color.primaryText.withValues(alpha: 0.45),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
