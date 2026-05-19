import 'package:flutter/material.dart';

/// Single looping animation shared by all [AnimatedCellGraphic] descendants.
class CellLoopAnimationScope extends StatefulWidget {
  const CellLoopAnimationScope({required this.child, super.key});

  final Widget child;

  static Animation<double> of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_InheritedCellLoopAnimation>();
    assert(scope != null, 'CellLoopAnimationScope not found in context');
    return scope!.animation;
  }

  @override
  State<CellLoopAnimationScope> createState() => _CellLoopAnimationScopeState();
}

class _CellLoopAnimationScopeState extends State<CellLoopAnimationScope> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _InheritedCellLoopAnimation(
        animation: _controller,
        child: widget.child,
      );
}

class _InheritedCellLoopAnimation extends InheritedWidget {
  const _InheritedCellLoopAnimation({required this.animation, required super.child});

  final Animation<double> animation;

  @override
  bool updateShouldNotify(_InheritedCellLoopAnimation oldWidget) => animation != oldWidget.animation;
}
