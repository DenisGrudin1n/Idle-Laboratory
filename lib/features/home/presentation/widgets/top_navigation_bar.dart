import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/cells_tab.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({required this.selectedTab, required this.onTabSelected, super.key});
  final CellsTab selectedTab;
  final ValueChanged<CellsTab> onTabSelected;

  @override
  Widget build(BuildContext context) => SectionCard(
        child: SizedBox(
          height: 50.h,
          child: Row(
            children: CellsTab.values.map((tab) => _TopTab(label: tab.localize(context.l10n), isActive: selectedTab == tab, onTap: () => onTabSelected(tab))).toList(),
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
              child: Text(label, style: TextStyle(color: context.color.primaryText, fontSize: 12.sp, fontWeight: isActive ? FontWeight.w600 : FontWeight.w400)),
            ),
          ),
        ),
      );
}
