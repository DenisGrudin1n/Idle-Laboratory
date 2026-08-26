import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/widgets/action_button.dart';
import 'package:idle_laboratory/core/widgets/info_row.dart';
import 'package:idle_laboratory/core/widgets/progress_bar_widget.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/core/widgets/section_header.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/prestige/prestige_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/controllers/tutorial_controller.dart';

class PrestigeInfoSection extends StatelessWidget {
  const PrestigeInfoSection({super.key});

  @override
  Widget build(BuildContext context) => BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
    selector: (state) => state.appVersion,
    builder: (context, appVersion) {
      final isMobile = appVersion == AppVersionEnum.mobile;
      final l10n = context.l10n;
      return SectionCard(
        key: TutorialController.prestigeKey,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.2,
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 12 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeader(
                  icon: Icons.auto_awesome,
                  title: l10n.prestige,
                  description: l10n.prestigeDescription,
                  iconSize: isMobile ? 16 : 26,
                  titleFontSize: isMobile ? 14 : 19,
                  descriptionFontSize: isMobile ? 9 : 13,
                  padding: isMobile ? const EdgeInsets.all(8) : const EdgeInsets.all(14),
                  borderRadius: isMobile ? 8 : 12,
                ),
                SizedBox(height: isMobile ? 8 : 24),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _PrestigeMultiplierSection(isMobile: isMobile),
                      SizedBox(height: isMobile ? 8 : 24),
                      _PrestigeProgressSection(isMobile: isMobile),
                      SizedBox(height: isMobile ? 12 : 36),
                      _PrestigeActionsSection(isMobile: isMobile),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _PrestigeMultiplierSection extends StatelessWidget {
  const _PrestigeMultiplierSection({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return RepaintBoundary(
      child: BlocSelector<PrestigeBloc, PrestigeState, ({BigNumber total, BigNumber current, bool isUnlocked})?>(
        selector: (state) {
          final prestigeState = state.prestigeState;
          if (prestigeState == null) return null;
          return (
            total: prestigeState.totalMultiplier,
            current: prestigeState.currentMultiplier,
            isUnlocked: prestigeState.isUnlocked,
          );
        },
        builder: (context, data) {
          if (data == null) return const SizedBox.shrink();
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.color.background.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.color.primary.withValues(alpha: 0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${l10n.prestigeMultiplier}: ${data.total.format(compact: true)}x',
                  style: context.styles.prestigeMultiplier,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: isMobile ? 3 : 9),
                Text(
                  '+ ${data.current.format(compact: true)}x ${l10n.prestigeBonus}',
                  style: context.styles.prestigeBonus(isUnlocked: data.isUnlocked),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PrestigeProgressSection extends StatelessWidget {
  const _PrestigeProgressSection({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return RepaintBoundary(
      child: BlocSelector<PrestigeBloc, PrestigeState, BigNumber?>(
        selector: (state) => state.prestigeState?.currentThreshold,
        builder: (context, threshold) {
          if (threshold == null) return const SizedBox.shrink();
          return BlocSelector<CellsBloc, CellsState, BigNumber?>(
            selector: (state) => state.totalEnergy,
            builder: (context, totalEnergy) {
              final currentEnergyText = totalEnergy?.format(compact: true) ?? '0.0';
              final progress = totalEnergy != null ? totalEnergy.ratio(threshold, max: 1) : 0.0;
              return Column(
                children: [
                  InfoRow(label: l10n.totalEnergy, value: currentEnergyText, valueColor: context.color.titleText),
                  SizedBox(height: isMobile ? 3 : 9),
                  InfoRow(
                    label: l10n.prestigeRequirement,
                    value: threshold.format(compact: true),
                    valueColor: context.color.primaryText,
                  ),
                  SizedBox(height: isMobile ? 6 : 18),
                  ProgressBarWidget(progress: progress),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _PrestigeActionsSection extends StatelessWidget {
  const _PrestigeActionsSection({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<PrestigeBloc, PrestigeState, ({bool isUnlocked, BigNumber threshold})?>(
      selector: (state) {
        final prestigeState = state.prestigeState;
        if (prestigeState == null) return null;
        return (isUnlocked: prestigeState.isUnlocked, threshold: prestigeState.currentThreshold);
      },
      builder: (context, data) {
        if (data == null) return const SizedBox.shrink();
        final button = ActionButton(
          icon: Icons.auto_awesome,
          label: data.isUnlocked ? l10n.prestigeButton : l10n.prestigeLocked(data.threshold.format(compact: true)),
          onTap: () => context.read<PrestigeBloc>().add(const PrestigeEvent.prestige()),
          isEnabled: data.isUnlocked,
          padding: isMobile ? const EdgeInsets.all(4) : const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          fontSize: isMobile ? 10 : 13,
          iconSize: isMobile ? 14 : 20,
          borderRadius: isMobile ? 8 : 12,
        );

        if (!kDebugMode) return button;

        return Row(
          children: [
            Expanded(child: button),
            SizedBox(width: isMobile ? 8 : 12),
            _PrestigeResetButton(isMobile: isMobile),
          ],
        );
      },
    );
  }
}

class _PrestigeResetButton extends StatelessWidget {
  const _PrestigeResetButton({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Reset Prestige'),
            content: const Text('This will reset all prestige progress to zero. Continue?'),
            actions: [
              TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancel')),
              TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('Reset')),
            ],
          ),
        );
        if ((confirm ?? false) && context.mounted) {
          context.read<PrestigeBloc>().add(const PrestigeEvent.resetPrestige());
        }
      },
      borderRadius: BorderRadius.circular(isMobile ? 8 : 12),
      child: Container(
        padding: isMobile ? const EdgeInsets.all(4) : const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(isMobile ? 8 : 12),
          border: Border.all(color: Colors.red.withValues(alpha: 0.5), width: 1.5),
        ),
        child: Icon(Icons.refresh, color: Colors.red, size: isMobile ? 14 : 22),
      ),
    ),
  );
}
