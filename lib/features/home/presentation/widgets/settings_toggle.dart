import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart';

class SettingsToggle extends StatelessWidget {
  const SettingsToggle({super.key});

  @override
  Widget build(BuildContext context) => BlocSelector<SettingsBloc, SettingsState, bool>(
    selector: (state) => state.isScientificNotation,
    builder: (context, isScientific) => Container(
      margin: const EdgeInsets.all(16),
      constraints: const BoxConstraints(minHeight: 40),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: context.color.drawerBackground, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(context.l10n.scientificNotation, style: context.styles.bodyLabel),
          InkWell(
            onTap: () => context.read<SettingsBloc>().add(const SettingsEvent.toggleScientificNotation()),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isScientific ? context.color.primary : context.color.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(isScientific ? context.l10n.on : context.l10n.off, style: context.styles.buttonLabel),
            ),
          ),
        ],
      ),
    ),
  );
}
