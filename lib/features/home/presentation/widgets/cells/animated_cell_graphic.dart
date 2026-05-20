import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/cell_loop_animation_scope.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/animated_cell_container.dart';

/// Stateless cell battery graphic using [CellLoopAnimationScope].
class AnimatedCellGraphic extends StatelessWidget {
  const AnimatedCellGraphic({required this.cellId, this.fillLevel = 1, super.key});

  final CellId cellId;
  final double fillLevel;

  @override
  Widget build(BuildContext context) => AnimatedCellContainer(
        fillLevel: fillLevel,
        visualTheme: context.getCellTheme(cellId),
        animation: CellLoopAnimationScope.of(context),
      );
}
