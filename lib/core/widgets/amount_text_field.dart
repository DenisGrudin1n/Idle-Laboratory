import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField({required this.controller, required this.onChanged, this.readOnly = false, super.key});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final styles = context.styles;

    return IntrinsicWidth(
      child: TapRegion(
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        child: TextField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
          onChanged: onChanged,
          style: styles.compactAccentValue.copyWith(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: readOnly ? color.primaryText.withValues(alpha: 0.5) : null,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            constraints: BoxConstraints(minWidth: 30.w),
            contentPadding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
            isDense: true,
            filled: true,
            fillColor: color.background.withValues(alpha: 0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: color.primary.withValues(alpha: 0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: color.primary.withValues(alpha: 0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: color.primary.withValues(alpha: 0.55), width: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
