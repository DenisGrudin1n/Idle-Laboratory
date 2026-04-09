import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';

class TopNavigationBar<T> extends StatelessWidget {
  const TopNavigationBar({
    required this.tabs,
    required this.selectedTab,
    required this.onTabSelected,
    required this.tabLabel,
    super.key,
  });

  final List<T> tabs;
  final T selectedTab;
  final ValueChanged<T> onTabSelected;
  final String Function(BuildContext context, T tab) tabLabel;

  @override
  Widget build(BuildContext context) => SectionCard(
        child: SizedBox(
          height: 50.h,
          child: Row(
            children: tabs
                .map(
                  (tab) => _TopTab(
                    label: tabLabel(context, tab),
                    isActive: tab == selectedTab,
                    onTap: () => onTabSelected(tab),
                  ),
                )
                .toList(),
          ),
        ),
      );
}

class _TopTab extends StatelessWidget {
  const _TopTab({required this.label, required this.isActive, required this.onTap});
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isActive ? context.color.primary.withValues(alpha: 0.3) : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: isActive ? context.color.primary : Colors.transparent, width: 1.w),
              ),
              child: Text(label, style: context.styles.navigationLabel(isActive: isActive)),
            ),
          ),
        ),
      );
}
