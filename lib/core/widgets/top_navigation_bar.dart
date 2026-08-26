import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/app_border_container.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';

import 'package:idle_laboratory/features/home/presentation/controllers/tutorial_controller.dart';

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
    key: TutorialController.topNavKey,
    child: BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isMobile = appVersion == AppVersionEnum.mobile;
        return Row(
          children: tabs
              .map(
                (tab) => _TopTab(
                  label: tabLabel(context, tab),
                  isActive: tab == selectedTab,
                  onTap: () => onTabSelected(tab),
                  badge: badgeBuilder?.call(context, tab),
                  isMobile: isMobile,
                ),
              )
              .toList(),
        );
      },
    ),
  );
}

class _TopTab extends StatelessWidget {
  const _TopTab({required this.label, required this.isActive, required this.onTap, required this.isMobile, this.badge});

  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Widget? badge;
  final bool isMobile;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: AppBorderContainer(
          isActive: isActive,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: isMobile ? 4 : 8),
          padding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 20),
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
