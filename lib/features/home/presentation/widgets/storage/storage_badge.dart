import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/storage/badge/storage_badge_cubit.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/storage/storage_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_material_slot_icon.dart';

class StorageBadge extends StatefulWidget {
  const StorageBadge({super.key});

  @override
  State<StorageBadge> createState() => _StorageBadgeState();
}

class _StorageBadgeState extends State<StorageBadge> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));

    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 10),
      TweenSequenceItem(tween: ConstantTween(1), weight: 70),
      TweenSequenceItem(tween: Tween(begin: 1, end: 0), weight: 20),
    ]).animate(_controller);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: const Offset(0, -0.2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StorageBloc, StorageState>(
      listenWhen: (prev, curr) => curr.lastAddedMaterial != null && curr.lastAddedTimestamp > prev.lastAddedTimestamp,
      listener: (context, state) {
        context.read<StorageBadgeCubit>().showMaterial(state.lastAddedMaterial!, state.lastAddedTimestamp);
        _controller.forward(from: 0);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return BlocSelector<StorageBadgeCubit, StorageBadgeState, ResearchMaterialId?>(
            selector: (state) => state.materialId,
            builder: (context, materialId) {
              if (materialId == null || _controller.isDismissed) return const SizedBox.shrink();

              return FadeTransition(
                opacity: _opacity,
                child: SlideTransition(
                  position: _slide,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '+1',
                        style: context.styles.compactAccentValue.copyWith(
                          color: context.color.green,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: ResearchMaterialSlotIcon(materialId: materialId),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
