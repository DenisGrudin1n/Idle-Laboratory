import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';
import 'package:idle_laboratory/lib.dart';

class PrestigeInfoSection extends StatelessWidget {
  const PrestigeInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;

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
                    _buildMultiplierDisplay(context, l10n),
                    SizedBox(height: 12.h),
                    _buildProgressSection(context, l10n),
                    SizedBox(height: 12.h),
                    _buildPrestigeButton(context, l10n),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

  Widget _buildMultiplierDisplay(BuildContext context, AppLocalizations l10n) {
    const double currentMultiplier = 10.0;
    const double nextBonus = 1.5;

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
          Row(
            children: <Widget>[
              Text(
                l10n.prestigeMultiplier,
                style: TextStyle(
                  color: context.color.primaryText,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: 3.w),
              Text(
                '${currentMultiplier.toStringAsFixed(1)}x',
                style: TextStyle(
                  color: context.color.primary,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),
          Text(
            '+ ${nextBonus.toStringAsFixed(1)}x ${l10n.prestigeBonus}',
            style: TextStyle(
              color: context.color.green,
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

  Widget _buildProgressSection(BuildContext context, AppLocalizations l10n) {
    const String currentEnergy = '15.0K';
    const String requirement = '10.0K';
    const double progress = 1.5;

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
            height: 6.h,
            child: LinearProgressIndicator(
              value: clampedProgress,
              backgroundColor: context.color.background,
              valueColor: AlwaysStoppedAnimation<Color>(
                isUnlocked ? context.color.green : context.color.primary,
              ),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          '${(progress * 100).toStringAsFixed(1)}%',
          style: TextStyle(
            color: isUnlocked ? context.color.green : context.color.primaryText,
            fontSize: 9.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPrestigeButton(BuildContext context, AppLocalizations l10n) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: context.color.primary,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: context.color.primary, width: 1.5.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.auto_awesome, color: Colors.white, size: 14.sp),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  l10n.prestigeButton,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
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
}
