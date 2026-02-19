import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/lib.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.2.sw,
      height: double.infinity,
      decoration: BoxDecoration(color: context.color.drawerBackground),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Energy display at the top of drawer
            const EnergyDisplay(),
            // Divider after energy section
            Divider(
              height: 1,
              thickness: 1,
              color: context.color.primaryText.withValues(alpha: 0.2),
            ),
            // Drawer tabs
            _DrawerTab(
              icon: Icons.science,
              label: 'Laboratory',
              isActive: selectedIndex == 0,
              onTap: () => onTabSelected(0),
            ),
            Divider(
              height: 1,
              thickness: 1,
              indent: 12.w,
              endIndent: 12.w,
              color: context.color.primaryText.withValues(alpha: 0.1),
            ),
            _DrawerTab(
              icon: Icons.filter_vintage,
              label: 'Chemicals',
              isActive: selectedIndex == 1,
              onTap: () => onTabSelected(1),
            ),
            Divider(
              height: 1,
              thickness: 1,
              indent: 12.w,
              endIndent: 12.w,
              color: context.color.primaryText.withValues(alpha: 0.1),
            ),
            _DrawerTab(
              icon: Icons.settings,
              label: 'Settings',
              isActive: selectedIndex == 2,
              onTap: () => onTabSelected(2),
            ),
            Divider(
              height: 1,
              thickness: 1,
              indent: 12.w,
              endIndent: 12.w,
              color: context.color.primaryText.withValues(alpha: 0.1),
            ),
            _DrawerTab(
              icon: Icons.bar_chart,
              label: 'Statistics',
              isActive: selectedIndex == 3,
              onTap: () => onTabSelected(3),
            ),
            Divider(
              height: 1,
              thickness: 1,
              indent: 12.w,
              endIndent: 12.w,
              color: context.color.primaryText.withValues(alpha: 0.1),
            ),
            _DrawerTab(
              icon: Icons.emoji_events,
              label: 'Achievements',
              isActive: selectedIndex == 4,
              onTap: () => onTabSelected(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTab extends StatelessWidget {
  const _DrawerTab({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isActive
                ? context.color.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isActive
                  ? context.color.primary.withValues(alpha: 0.3)
                  : Colors.transparent,
              width: 1.w,
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(icon, color: context.color.primaryText, size: 16.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: context.color.primaryText,
                    fontSize: 12.sp,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
