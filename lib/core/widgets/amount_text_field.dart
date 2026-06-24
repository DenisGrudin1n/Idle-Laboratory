import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField({required this.controller, required this.onChanged, this.readOnly = false, super.key});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final styles = context.styles;

    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isMobile = appVersion == AppVersionEnum.mobile;
        final isDesk = appVersion == AppVersionEnum.desk;

        final verticalPadding = isDesk ? 7.0 : 4.0;
        final horizontalPadding = !isMobile ? 10.0 : 7.0;

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
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: readOnly ? color.primaryText.withValues(alpha: 0.5) : null,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                constraints: const BoxConstraints(minWidth: 30),
                contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                isDense: true,
                filled: true,
                fillColor: color.background.withValues(alpha: 0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: color.primary.withValues(alpha: 0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: color.primary.withValues(alpha: 0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: color.primary.withValues(alpha: 0.55), width: 1.5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
