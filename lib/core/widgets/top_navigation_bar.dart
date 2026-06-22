import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';

class TopNavigationBar<T> extends StatelessWidget {
  const TopNavigationBar({
    required this.tabs,
    required this.selectedTab,
    required this.onTabSelected,
    required this.tabLabel,
    this.badgeBuilder,
    super.key,
  });

  final List<T> tabs;
  final T selectedTab;
  final ValueChanged<T> onTabSelected;
  final String Function(BuildContext context, T tab) tabLabel;
  final Widget? Function(BuildContext context, T tab)? badgeBuilder;

  @override
  Widget build(BuildContext context) => SectionCard(
    child: SizedBox(
      height: 50,
      child: Row(
        children: tabs
            .map(
              (tab) => _TopTab(
                label: tabLabel(context, tab),
                isActive: tab == selectedTab,
                onTap: () => onTabSelected(tab),
                badge: badgeBuilder?.call(context, tab),
              ),
            )
            .toList(),
      ),
    ),
  );
}

class _TopTab extends StatelessWidget {
  const _TopTab({required this.label, required this.isActive, required this.onTap, this.badge});

  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Widget? badge;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: isActive ? context.color.primary.withValues(alpha: 0.3) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isActive ? context.color.primary : Colors.transparent),
          ),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Text(label, style: context.styles.navigationLabel(isActive: isActive)),
              if (badge != null) Positioned(left: 32, bottom: 10, child: badge!),
            ],
          ),
        ),
      ),
    ),
  );
}
