import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';
import 'package:idle_laboratory/lib.dart';

class PrestigeInfoSection extends StatelessWidget {
  const PrestigeInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;

    return BlocBuilder<PrestigeCubit, PrestigeState>(
      builder: (BuildContext context, PrestigeState state) {
        final PrestigeStateModel? prestigeState = state.prestigeState;
        if (prestigeState == null) {
          return const SizedBox.shrink();
        }

        return SectionCard(
          child: SizedBox(
            width: 0.2.sw,
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildHeader(context, l10n),
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
      },
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: context.color.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.auto_awesome,
            color: context.color.primary,
            size: 16.sp,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                l10n.prestige,
                style: TextStyle(
                  color: context.color.titleText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 1.h),
              Text(
                l10n.prestigeDescription,
                style: TextStyle(
                  color: context.color.primaryText.withValues(alpha: 0.7),
                  fontSize: 9.sp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMultiplierDisplay(
    BuildContext context,
    AppLocalizations l10n,
    PrestigeStateModel prestigeState,
  ) {
    final String currentMultiplier = prestigeState.totalMultiplier.format(
      compact: true,
    );
    final String nextBonus = prestigeState.currentMultiplier.format(
      compact: true,
    );

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
    return BlocBuilder<CellsCubit, CellsState>(
      builder: (BuildContext context, CellsState cellsState) {
        final String currentEnergy =
            cellsState.totalEnergy?.format(compact: true) ?? '0.0';
        final String requirement = prestigeState.currentThreshold.format(
          compact: true,
        );
        final double progress = cellsState.totalEnergy != null
            ? cellsState.totalEnergy!.ratio(
                prestigeState.currentThreshold,
                max: 1.0,
              )
            : 0.0;

        return Column(
          children: <Widget>[
            _buildInfoRow(
              context,
              l10n.totalEnergy,
              currentEnergy,
              context.color.titleText,
            ),
            SizedBox(height: 3.h),
            _buildInfoRow(
              context,
              l10n.prestigeRequirement,
              requirement,
              context.color.primaryText,
            ),
            SizedBox(height: 6.h),
            _buildProgressBar(context, progress),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    Color valueColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: context.color.primaryText, fontSize: 10.sp),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context, double progress) {
    final double clampedProgress = progress.clamp(0.0, 1.0);
    final bool isUnlocked = progress >= 1.0;

    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: SizedBox(
            height: 8.h,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: 12.h,
                  child: LinearProgressIndicator(
                    value: clampedProgress,
                    backgroundColor: context.color.background,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isUnlocked ? context.color.green : context.color.primary,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      '${(progress * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: context.color.titleText,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            color: context.color.background,
                            blurRadius: 4,
                          ),
                          Shadow(
                            color: context.color.background,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrestigeButton(
    BuildContext context,
    AppLocalizations l10n,
    PrestigeStateModel prestigeState,
  ) {
    final bool isLocked = !prestigeState.isUnlocked;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLocked
            ? null
            : () {
                context.read<PrestigeCubit>().prestige();
              },
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: isLocked
                ? context.color.primaryText.withValues(alpha: 0.3)
                : context.color.primary,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isLocked
                  ? context.color.primaryText.withValues(alpha: 0.5)
                  : context.color.primary,
              width: 1.5.w,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.auto_awesome,
                color: isLocked
                    ? context.color.primaryText.withValues(alpha: 0.5)
                    : Colors.white,
                size: 14.sp,
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  isLocked
                      ? l10n.prestigeLocked(
                          prestigeState.currentThreshold.format(compact: true),
                        )
                      : l10n.prestigeButton,
                  style: TextStyle(
                    color: isLocked
                        ? context.color.primaryText.withValues(alpha: 0.5)
                        : Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final bool? confirm = await showDialog<bool>(
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

          if (confirm == true && context.mounted) {
            context.read<PrestigeCubit>().resetPrestige();
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
