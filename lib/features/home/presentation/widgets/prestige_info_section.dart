import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/action_button.dart';
import 'package:idle_laboratory/core/widgets/info_row.dart';
import 'package:idle_laboratory/core/widgets/progress_bar_widget.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/core/widgets/section_header.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/prestige/prestige_bloc.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

class PrestigeInfoSection extends StatelessWidget {
  const PrestigeInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final prestigeState = context.select(
      (PrestigeBloc bloc) => bloc.state.prestigeState,
    );
    if (prestigeState == null) return const SizedBox.shrink();

    return SectionCard(
      child: SizedBox(
        width: 0.2.sw,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SectionHeader(
                icon: Icons.auto_awesome,
                title: l10n.prestige,
                description: l10n.prestigeDescription,
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildMultiplierDisplay(context, l10n, prestigeState),
                    SizedBox(height: 8.h),
                    _buildProgressSection(context, l10n, prestigeState),
                    SizedBox(height: 12.h),
                    if (kDebugMode)
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _buildPrestigeButton(
                              context,
                              l10n,
                              prestigeState,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          _buildResetButton(context),
                        ],
                      )
                    else
                      _buildPrestigeButton(context, l10n, prestigeState),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMultiplierDisplay(
    BuildContext context,
    AppLocalizations l10n,
    PrestigeStateModel prestigeState,
  ) {
    final currentMultiplier = prestigeState.totalMultiplier.format(
      compact: true,
    );
    final nextBonus = prestigeState.currentMultiplier.format(compact: true);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.color.background.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.color.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${l10n.prestigeMultiplier}: ${currentMultiplier}x',
            style: TextStyle(
              color: context.color.primary,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 3.h),
          Text(
            '+ ${nextBonus}x ${l10n.prestigeBonus}',
            style: TextStyle(
              color: prestigeState.isUnlocked
                  ? context.color.green
                  : context.color.primaryText.withValues(alpha: 0.5),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(
    BuildContext context,
    AppLocalizations l10n,
    PrestigeStateModel prestigeState,
  ) {
    final currentEnergy = context.select(
      (CellsBloc bloc) =>
          bloc.state.totalEnergy?.format(compact: true) ?? '0.0',
    );

    final progress = context.select(
      (CellsBloc bloc) => bloc.state.totalEnergy != null
          ? bloc.state.totalEnergy!.ratio(
              prestigeState.currentThreshold,
              max: 1,
            )
          : 0.0,
    );

    final requirement = prestigeState.currentThreshold.format(compact: true);

    return Column(
      children: <Widget>[
        InfoRow(
          label: l10n.totalEnergy,
          value: currentEnergy,
          valueColor: context.color.titleText,
        ),
        SizedBox(height: 3.h),
        InfoRow(
          label: l10n.prestigeRequirement,
          value: requirement,
          valueColor: context.color.primaryText,
        ),
        SizedBox(height: 6.h),
        ProgressBarWidget(progress: progress),
      ],
    );
  }

  Widget _buildPrestigeButton(
    BuildContext context,
    AppLocalizations l10n,
    PrestigeStateModel prestigeState,
  ) {
    final isUnlocked = prestigeState.isUnlocked;

    return ActionButton(
      icon: Icons.auto_awesome,
      label: isUnlocked
          ? l10n.prestigeButton
          : l10n.prestigeLocked(
              prestigeState.currentThreshold.format(compact: true),
            ),
      onTap: () =>
          context.read<PrestigeBloc>().add(const PrestigeEvent.prestige()),
      isEnabled: isUnlocked,
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (BuildContext ctx) => AlertDialog(
              title: const Text('Reset Prestige'),
              content: const Text(
                'This will reset all prestige progress to zero. Continue?',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: const Text('Reset'),
                ),
              ],
            ),
          );

          if ((confirm ?? false) && context.mounted) {
            context.read<PrestigeBloc>().add(
              const PrestigeEvent.resetPrestige(),
            );
          }
        },
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Colors.red.withValues(alpha: 0.5),
              width: 1.5.w,
            ),
          ),
          child: Icon(Icons.refresh, color: Colors.red, size: 14.sp),
        ),
      ),
    );
  }
}
