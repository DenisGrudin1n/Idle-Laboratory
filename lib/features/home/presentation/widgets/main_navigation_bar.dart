import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/main_navigation_tab.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/energy_display.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({required this.selectedTab, required this.onTabSelected, super.key});
  final MainNavigationTab selectedTab;
  final ValueChanged<MainNavigationTab> onTabSelected;

  @override
  Widget build(BuildContext context) => SectionCard(
        child: SizedBox(
          width: 0.2.sw,
          height: double.infinity,
          child: ListView.separated(
            itemCount: MainNavigationTab.values.length + 1,
            separatorBuilder: (context, index) => index == 0
                ? Divider(height: 1, thickness: 1, color: context.color.primaryText.withValues(alpha: 0.2))
                : Divider(height: 1, thickness: 1, indent: 12.w, endIndent: 12.w, color: context.color.primaryText.withValues(alpha: 0.1)),
            itemBuilder: (context, index) {
              if (index == 0) return const EnergyDisplay();
              final tab = MainNavigationTab.values[index - 1];
              return _DrawerTab(icon: tab.icon, label: tab.localize(context.l10n), isActive: selectedTab == tab, onTap: () => onTabSelected(tab));
            },
          ),
        ),
      );
}

class _DrawerTab extends StatelessWidget {
  const _DrawerTab({required this.icon, required this.label, required this.isActive, required this.onTap});
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isActive ? context.color.primary.withValues(alpha: 0.3) : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: isActive ? context.color.primary : Colors.transparent, width: 1.w),
            ),
            child: Row(
              children: [
                Icon(icon, color: context.color.primaryText, size: 16.sp),
                SizedBox(width: 8.w),
                Expanded(child: Text(label, style: TextStyle(color: context.color.primaryText, fontSize: 12.sp, fontWeight: isActive ? FontWeight.w600 : FontWeight.w400))),
              ],
            ),
          ),
        ),
      );
}
