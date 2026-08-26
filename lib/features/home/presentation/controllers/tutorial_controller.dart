import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/cells_tab.dart';
import 'package:idle_laboratory/core/enums/crafting_tab.dart';
import 'package:idle_laboratory/core/enums/magician_emotion.dart';
import 'package:idle_laboratory/core/enums/tutorial_target_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/app_color.dart';
import 'package:idle_laboratory/core/theme/app_textstyles.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/magician_sprite.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialController {
  TutorialController._();

  static final GlobalKey energyKey = GlobalKey();
  static final GlobalKey mainNavKey = GlobalKey();
  static final GlobalKey topNavKey = GlobalKey();
  static final GlobalKey cellsListKey = GlobalKey();
  static final GlobalKey prestigeKey = GlobalKey();
  static final GlobalKey productionCellKey = GlobalKey();
  static final GlobalKey craftingContainerKey = GlobalKey();
  static final GlobalKey craftingCellSlotKey = GlobalKey();
  static final GlobalKey craftingMaterialSlotsKey = GlobalKey();
  static final GlobalKey craftingOutputSlotKey = GlobalKey();
  static final GlobalKey craftingInfoRowKey = GlobalKey();
  static final GlobalKey storageContainerKey = GlobalKey();
  static final GlobalKey researchTreeKey = GlobalKey();
  static final GlobalKey researchGoalKey = GlobalKey();

  static void showTutorial(BuildContext context) {
    final targets = _createTargets(context);
    _showTargets(context, targets);
  }

  static void showTabTutorial(BuildContext context, {CellsTab? cellsTab, CraftingTab? craftingTab}) {
    final targets = switch ((cellsTab, craftingTab)) {
      (CellsTab.production, _) => _createProductionTargets(context),
      (_, CraftingTab.crafting) => _createCraftingTargets(context),
      (_, CraftingTab.storage) => _createStorageTargets(context),
      (_, CraftingTab.research) => _createResearchTargets(context),
      _ => <TargetFocus>[],
    };

    if (targets.isNotEmpty) {
      _showTargets(context, targets);
    }
  }

  static void _showTargets(BuildContext context, List<TargetFocus> targets, {VoidCallback? onFinish}) {
    final styles = context.styles;
    final l10n = context.l10n;
    final appVersion = context.read<AppLayoutBloc>().state.appVersion;
    final isTablet = appVersion == AppVersionEnum.tablet;
    final isDesk = appVersion == AppVersionEnum.desk;
    final skipGap = isDesk ? 48.0 : (isTablet ? 32.0 : 16.0);

    TutorialCoachMark(
      targets: targets,
      opacityShadow: 0.9,
      skipWidget: Padding(
        padding: EdgeInsets.only(right: skipGap, bottom: skipGap),
        child: Text(
          l10n.tutorialSkip,
          style: styles.compactAccentValue.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      onFinish: onFinish,
      onSkip: () {
        onFinish?.call();
        return true;
      },
    ).show(context: context);
  }

  static List<TargetFocus> _createTargets(BuildContext context) {
    final targets = <TargetFocus>[];
    final color = context.color;
    final styles = context.styles;
    final l10n = context.l10n;
    final size = MediaQuery.sizeOf(context);
    final appVersion = context.read<AppLayoutBloc>().state.appVersion;
    final isMobile = appVersion == AppVersionEnum.mobile;
    final isTablet = appVersion == AppVersionEnum.tablet;
    final isDesk = appVersion == AppVersionEnum.desk;

    final sidebarWidth = size.width * (isMobile ? 0.27 : 0.24);
    final sidePanelWidth = size.width * (isMobile ? 0.27 : 0.24);
    final horizontalPadding = isDesk ? 60.0 : (isTablet ? 24.0 : 16.0);
    final energyTopOffset = isDesk ? 150.0 : (isTablet ? 130.0 : 80.0);
    final topNavTopOffset = isDesk ? 160.0 : (isTablet ? 120.0 : 100.0);
    final sidebarGap = isDesk ? 24.0 : (isTablet ? 16.0 : 8.0);
    final spriteSize = isDesk ? 260.0 : (isTablet ? 200.0 : 140.0);

    targets
      ..add(
        TargetFocus(
          identify: TutorialTargetId.welcome.id,
          enableTargetTab: false,
          targetPosition: TargetPosition(const Size(1, 1), Offset(size.width / 2, size.height / 2)),
          contents: [
            TargetContent(
              align: ContentAlign.custom,
              customPosition: CustomTargetContentPosition(top: 0, bottom: 0, left: 0, right: 0),
              builder: (context, controller) {
                return Stack(
                  children: [
                    Positioned(
                      left: horizontalPadding,
                      bottom: 24,
                      child: MagicianSprite(emotion: MagicianEmotion.kind, size: spriteSize),
                    ),
                    Center(
                      child: _buildTooltip(
                        context: context,
                        title: l10n.tutorialWelcomeTitle,
                        description: l10n.tutorialWelcomeDesc,
                        color: color,
                        styles: styles,
                        onNext: controller.next,
                        maxWidth: isDesk ? 700 : (isTablet ? 600 : 500),
                        appVersion: appVersion,
                        l10nNext: l10n.tutorialNext,
                        showMagician: false,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      )
      ..add(
        TargetFocus(
          identify: TutorialTargetId.energy.id,
          keyTarget: energyKey,
          enableTargetTab: false,
          shape: ShapeLightFocus.RRect,
          radius: 12,
          contents: [
            TargetContent(
              align: ContentAlign.custom,
              customPosition: CustomTargetContentPosition(top: energyTopOffset, left: horizontalPadding),
              builder: (context, controller) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: _buildTooltip(
                    context: context,
                    title: l10n.tutorialEnergyTitle,
                    description: l10n.tutorialEnergyDesc,
                    color: color,
                    styles: styles,
                    onNext: controller.next,
                    maxWidth: isDesk ? 400 : (isTablet ? 350 : 300),
                    appVersion: appVersion,
                    l10nNext: l10n.tutorialNext,
                    magicianOnRight: true,
                  ),
                );
              },
            ),
          ],
        ),
      )
      ..add(
        TargetFocus(
          identify: TutorialTargetId.mainNav.id,
          keyTarget: mainNavKey,
          enableTargetTab: false,
          shape: ShapeLightFocus.RRect,
          radius: 12,
          contents: [
            TargetContent(
              align: ContentAlign.custom,
              customPosition: CustomTargetContentPosition(bottom: 40, left: sidebarWidth + horizontalPadding),
              builder: (context, controller) {
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: _buildTooltip(
                    context: context,
                    title: l10n.tutorialMainNavTitle,
                    description: l10n.tutorialMainNavDesc,
                    color: color,
                    styles: styles,
                    onNext: controller.next,
                    appVersion: appVersion,
                    l10nNext: l10n.tutorialNext,
                    magicianOnRight: true,
                  ),
                );
              },
            ),
          ],
        ),
      )
      ..add(
        TargetFocus(
          identify: TutorialTargetId.topNav.id,
          keyTarget: topNavKey,
          enableTargetTab: false,
          shape: ShapeLightFocus.RRect,
          radius: 12,
          contents: [
            TargetContent(
              align: ContentAlign.custom,
              customPosition: CustomTargetContentPosition(
                top: topNavTopOffset,
                left: sidebarWidth + sidebarGap,
                right: horizontalPadding,
              ),
              builder: (context, controller) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: _buildTooltip(
                    context: context,
                    title: l10n.tutorialSubTabsTitle,
                    description: l10n.tutorialSubTabsDesc,
                    color: color,
                    styles: styles,
                    onNext: controller.next,
                    maxWidth: isDesk ? 500 : (isTablet ? 450 : 380),
                    appVersion: appVersion,
                    l10nNext: l10n.tutorialNext,
                  ),
                );
              },
            ),
          ],
        ),
      )
      ..add(
        TargetFocus(
          identify: TutorialTargetId.cellsList.id,
          keyTarget: cellsListKey,
          enableTargetTab: false,
          shape: ShapeLightFocus.RRect,
          radius: 12,
          contents: [
            TargetContent(
              align: ContentAlign.custom,
              customPosition: CustomTargetContentPosition(top: isMobile ? 20 : 100, left: sidebarWidth * 2),
              builder: (context, controller) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: _buildTooltip(
                    context: context,
                    title: l10n.tutorialCellsListTitle,
                    description: l10n.tutorialCellsListDesc,
                    color: color,
                    styles: styles,
                    onNext: controller.next,
                    appVersion: appVersion,
                    l10nNext: l10n.tutorialNext,
                    magicianOnRight: true,
                    magicianOnTop: true,
                  ),
                );
              },
            ),
          ],
        ),
      )
      ..add(
        TargetFocus(
          identify: TutorialTargetId.prestige.id,
          keyTarget: prestigeKey,
          enableTargetTab: false,
          shape: ShapeLightFocus.RRect,
          radius: 12,
          contents: [
            TargetContent(
              align: ContentAlign.custom,
              customPosition: CustomTargetContentPosition(bottom: 100, right: sidePanelWidth + horizontalPadding),
              builder: (context, controller) {
                return Align(
                  alignment: Alignment.bottomRight,
                  child: _buildTooltip(
                    context: context,
                    title: l10n.tutorialPrestigeTitle,
                    description: l10n.tutorialPrestigeDesc,
                    color: color,
                    styles: styles,
                    onNext: controller.next,
                    appVersion: appVersion,
                    l10nNext: l10n.tutorialNext,
                  ),
                );
              },
            ),
          ],
        ),
      );

    return targets;
  }

  static List<TargetFocus> _createProductionTargets(BuildContext context) {
    final color = context.color;
    final styles = context.styles;
    final l10n = context.l10n;
    final appVersion = context.read<AppLayoutBloc>().state.appVersion;
    final isDesk = appVersion == AppVersionEnum.desk;
    final isTablet = appVersion == AppVersionEnum.tablet;
    final horizontalPadding = isDesk ? 80.0 : (isTablet ? 24.0 : 16.0);

    return [
      TargetFocus(
        identify: TutorialTargetId.productionCell.id,
        keyTarget: productionCellKey,
        enableTargetTab: false,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, controller) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: horizontalPadding, top: horizontalPadding),
                  child: _buildTooltip(
                    context: context,
                    title: l10n.tutorialProductionTitle,
                    description: l10n.tutorialProductionDesc,
                    color: color,
                    styles: styles,
                    onNext: controller.next,
                    appVersion: appVersion,
                    l10nNext: l10n.tutorialNext,
                    magicianOnRight: true,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ];
  }

  static List<TargetFocus> _createCraftingTargets(BuildContext context) {
    final color = context.color;
    final styles = context.styles;
    final l10n = context.l10n;
    final size = MediaQuery.sizeOf(context);
    final appVersion = context.read<AppLayoutBloc>().state.appVersion;
    final isDesk = appVersion == AppVersionEnum.desk;
    final isTablet = appVersion == AppVersionEnum.tablet;
    final isMobile = appVersion == AppVersionEnum.mobile;
    final horizontalPadding = isDesk ? 80.0 : (isTablet ? 24.0 : 16.0);
    final sidebarWidth = size.width * (isMobile ? 0.27 : 0.24);

    return [
      TargetFocus(
        identify: TutorialTargetId.craftingContainer.id,
        keyTarget: craftingContainerKey,
        enableTargetTab: false,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(left: horizontalPadding, top: size.height * 0.35),
            builder: (context, controller) {
              return Align(
                alignment: Alignment.centerLeft,
                child: _buildTooltip(
                  context: context,
                  title: l10n.tutorialCraftingTitle,
                  description: l10n.tutorialCraftingDesc,
                  color: color,
                  styles: styles,
                  onNext: controller.next,
                  appVersion: appVersion,
                  l10nNext: l10n.tutorialNext,
                ),
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: TutorialTargetId.craftingCellSlot.id,
        keyTarget: craftingCellSlotKey,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        enableTargetTab: false,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: sidebarWidth + 48, bottom: 24),
                  child: _buildTooltip(
                    context: context,
                    title: l10n.tutorialCraftingCellSlotTitle,
                    description: l10n.tutorialCraftingCellSlotDesc,
                    color: color,
                    styles: styles,
                    onNext: controller.next,
                    appVersion: appVersion,
                    l10nNext: l10n.tutorialNext,
                    magicianOnRight: true,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: TutorialTargetId.craftingMaterialSlots.id,
        keyTarget: craftingMaterialSlotsKey,
        enableTargetTab: false,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, controller) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: _buildTooltip(
                    context: context,
                    title: l10n.tutorialCraftingMaterialSlotsTitle,
                    description: l10n.tutorialCraftingMaterialSlotsDesc,
                    color: color,
                    styles: styles,
                    onNext: controller.next,
                    appVersion: appVersion,
                    l10nNext: l10n.tutorialNext,
                    magicianOnRight: true,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: TutorialTargetId.craftingOutputSlot.id,
        keyTarget: craftingOutputSlotKey,
        enableTargetTab: false,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, controller) {
              return Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: _buildTooltip(
                    context: context,
                    title: l10n.tutorialCraftingOutputSlotTitle,
                    description: l10n.tutorialCraftingOutputSlotDesc,
                    color: color,
                    styles: styles,
                    onNext: controller.next,
                    appVersion: appVersion,
                    l10nNext: l10n.tutorialNext,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: TutorialTargetId.craftingInfoRow.id,
        keyTarget: craftingInfoRowKey,
        enableTargetTab: false,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(bottom: 40, left: sidebarWidth * (isMobile ? 0.9 : 1.1)),
            builder: (context, controller) {
              return Align(
                alignment: Alignment.bottomLeft,
                child: _buildTooltip(
                  context: context,
                  title: l10n.tutorialCraftingInfoTitle,
                  description: l10n.tutorialCraftingInfoDesc,
                  color: color,
                  styles: styles,
                  onNext: controller.next,
                  appVersion: appVersion,
                  l10nNext: l10n.tutorialNext,
                ),
              );
            },
          ),
        ],
      ),
    ];
  }

  static List<TargetFocus> _createStorageTargets(BuildContext context) {
    final color = context.color;
    final styles = context.styles;
    final l10n = context.l10n;
    final size = MediaQuery.sizeOf(context);
    final appVersion = context.read<AppLayoutBloc>().state.appVersion;
    final isDesk = appVersion == AppVersionEnum.desk;
    final isTablet = appVersion == AppVersionEnum.tablet;
    final horizontalPadding = isDesk ? 80.0 : (isTablet ? 24.0 : 16.0);

    return [
      TargetFocus(
        identify: TutorialTargetId.storageContainer.id,
        keyTarget: storageContainerKey,
        enableTargetTab: false,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(left: horizontalPadding, top: size.height * 0.35),
            builder: (context, controller) {
              return Align(
                alignment: Alignment.centerLeft,
                child: _buildTooltip(
                  context: context,
                  title: l10n.tutorialStorageTitle,
                  description: l10n.tutorialStorageDesc,
                  color: color,
                  styles: styles,
                  onNext: controller.next,
                  appVersion: appVersion,
                  l10nNext: l10n.tutorialNext,
                ),
              );
            },
          ),
        ],
      ),
    ];
  }

  static List<TargetFocus> _createResearchTargets(BuildContext context) {
    final color = context.color;
    final styles = context.styles;
    final l10n = context.l10n;
    final size = MediaQuery.sizeOf(context);
    final appVersion = context.read<AppLayoutBloc>().state.appVersion;
    final isDesk = appVersion == AppVersionEnum.desk;
    final isTablet = appVersion == AppVersionEnum.tablet;
    final isMobile = appVersion == AppVersionEnum.mobile;
    final horizontalPadding = isDesk ? 80.0 : (isTablet ? 24.0 : 16.0);

    return [
      TargetFocus(
        identify: TutorialTargetId.researchTree.id,
        keyTarget: researchTreeKey,
        enableTargetTab: false,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(left: horizontalPadding, top: size.height * 0.35),
            builder: (context, controller) {
              return Align(
                alignment: Alignment.centerLeft,
                child: _buildTooltip(
                  context: context,
                  title: l10n.tutorialResearchTitle,
                  description: l10n.tutorialResearchDesc,
                  color: color,
                  styles: styles,
                  onNext: controller.next,
                  appVersion: appVersion,
                  l10nNext: l10n.tutorialNext,
                ),
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: TutorialTargetId.researchGoal.id,
        keyTarget: researchGoalKey,
        enableTargetTab: false,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(
              bottom: isMobile ? 40 : 80,
              left: horizontalPadding,
              right: horizontalPadding,
            ),
            builder: (context, controller) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: _buildTooltip(
                  context: context,
                  title: l10n.tutorialResearchGoalTitle,
                  description: l10n.tutorialResearchGoalDesc,
                  color: color,
                  styles: styles,
                  onNext: controller.next,
                  appVersion: appVersion,
                  l10nNext: l10n.tutorialNext,
                  emotion: MagicianEmotion.greedy,
                ),
              );
            },
          ),
        ],
      ),
    ];
  }

  static Widget _buildTooltip({
    required BuildContext context,
    required String title,
    required String description,
    required AppColor color,
    required AppTextStyles styles,
    required VoidCallback onNext,
    required AppVersionEnum appVersion,
    required String l10nNext,
    double? maxWidth,
    bool magicianOnRight = false,
    bool magicianOnTop = false,
    MagicianEmotion emotion = MagicianEmotion.kind,
    bool showMagician = true,
  }) {
    final screenSize = MediaQuery.sizeOf(context);
    final isMobile = appVersion == AppVersionEnum.mobile;
    final isTablet = appVersion == AppVersionEnum.tablet;
    final isDesk = appVersion == AppVersionEnum.desk;

    final defaultMaxWidth = isDesk ? 420.0 : (isTablet ? 340.0 : 280.0);
    final effectiveMaxWidth = maxWidth ?? defaultMaxWidth;
    final padding = isDesk ? 28.0 : (isTablet ? 20.0 : 16.0);
    final borderRadius = isDesk ? 24.0 : (isTablet ? 16.0 : 12.0);
    final borderWidth = isDesk ? 3.0 : (isTablet ? 2.0 : 1.5);
    final titleSize = isDesk ? 22.0 : (isTablet ? 18.0 : 16.0);
    final descSize = isDesk ? 16.0 : (isTablet ? 14.0 : 13.0);
    final buttonHeight = isMobile ? 32.0 : (isTablet ? 44.0 : 52.0);
    final spriteSize = isDesk ? 280.0 : (isTablet ? 220.0 : 160.0);
    final buttonPadding = isMobile
        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 4)
        : (isTablet
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
              : const EdgeInsets.symmetric(horizontal: 24, vertical: 12));

    // Simple scaling logic based on screen width
    var currentSpriteSize = spriteSize;
    var actualShowMagician = showMagician;

    final availableWidth = screenSize.width - 48; // Basic margin
    if (actualShowMagician) {
      if (magicianOnTop) {
        // For top placement, we check available height instead of width
        if (screenSize.height < (currentSpriteSize + 200)) {
          currentSpriteSize = (screenSize.height - 200).clamp(spriteSize / 2, spriteSize);
        }
      } else {
        if (availableWidth < (effectiveMaxWidth + spriteSize)) {
          currentSpriteSize = (availableWidth - effectiveMaxWidth).clamp(0.0, spriteSize);
          if (currentSpriteSize < spriteSize / 2) {
            actualShowMagician = false;
          }
        }
      }
    }

    final tooltipContent = Container(
      constraints: BoxConstraints(
        maxWidth: effectiveMaxWidth,
        maxHeight: screenSize.height * 0.7, // Prevent vertical overflow
      ),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color.background,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: color.primary, width: borderWidth),
        boxShadow: [BoxShadow(color: color.primary.withValues(alpha: 0.4), blurRadius: 15, spreadRadius: 2)],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: styles.sectionTitle.copyWith(color: color.primary, fontSize: titleSize),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Text(
              description,
              style: styles.helperText.copyWith(color: color.primaryText, fontSize: descSize, height: 1.4),
            ),
            SizedBox(height: isMobile ? 16 : 24),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: onNext,
                style: TextButton.styleFrom(
                  backgroundColor: color.primary.withValues(alpha: 0.15),
                  padding: buttonPadding,
                  minimumSize: Size(0, buttonHeight),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(isMobile ? 8 : 12),
                    side: BorderSide(color: color.primary.withValues(alpha: 0.5)),
                  ),
                ),
                child: Text(
                  l10nNext,
                  style: styles.compactAccentValue.copyWith(
                    color: color.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: isMobile ? 12 : 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final sprite = actualShowMagician
        ? MagicianSprite(emotion: emotion, size: currentSpriteSize, flipped: magicianOnRight)
        : const SizedBox.shrink();

    if (magicianOnTop && actualShowMagician) {
      return Column(mainAxisSize: MainAxisSize.min, children: [sprite, const SizedBox(height: 4), tooltipContent]);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (actualShowMagician && !magicianOnRight) ...[sprite, const SizedBox(width: 4)],
        Flexible(child: tooltipContent),
        if (actualShowMagician && magicianOnRight) ...[const SizedBox(width: 4), sprite],
      ],
    );
  }
}
