import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Slot layout for a 1 → 2 → 4 → 8 → 16 research pyramid (top to bottom).
///
/// Bottom row is spaced across [availW]; each upper level places slots at
/// midpoints of the two children below, so center-to-center spacing doubles
/// each step up and conduits stay aligned.
abstract final class ResearchTreeGeometry {
  ResearchTreeGeometry._();

  static const slotsPerRowTopToBottom = [1, 2, 4, 8, 16];

  static const _minBottomGap = 2.0;

  /// Returns row rects (top row first) and total content size for [slotSide] / gaps.
  static ({double width, double height, List<List<Rect>> rows}) layout({
    required double maxWidth,
    required double slotSide,
    required double rowGap,
    required double marginH,
    required double marginV,
  }) {
    final availW = math.max(0, maxWidth - 2 * marginH);
    const nBottom = 16;
    final bottomGap = nBottom > 1
        ? ((availW - nBottom * slotSide) / (nBottom - 1)).clamp(_minBottomGap, double.infinity)
        : 0.0;

    final bottomCenters = List<double>.generate(
      nBottom,
      (i) => marginH + i * (slotSide + bottomGap) + slotSide / 2,
    );

    final levelsBottomToTop = <List<double>>[bottomCenters];
    var cur = bottomCenters;
    while (cur.length > 1) {
      cur = [
        for (var i = 0; i < cur.length; i += 2) (cur[i] + cur[i + 1]) / 2,
      ];
      levelsBottomToTop.add(cur);
    }

    final rows = <List<Rect>>[];
    for (var t = 0; t < slotsPerRowTopToBottom.length; t++) {
      final levelFromTop = slotsPerRowTopToBottom.length - 1 - t;
      final centers = levelsBottomToTop[levelFromTop];
      final y = marginV + t * (slotSide + rowGap);
      rows.add(
        [
          for (final cx in centers)
            Rect.fromCenter(
              center: Offset(cx, y + slotSide / 2),
              width: slotSide,
              height: slotSide,
            ),
        ],
      );
    }

    final height = marginV + 5 * slotSide + 4 * rowGap + marginV;
    return (width: maxWidth, height: height, rows: rows);
  }

  /// Shrinks [slotSide] until the tree fits [maxHeight] (if possible).
  static ({double width, double height, List<List<Rect>> rows, double slotSide}) layoutFitted({
    required double maxWidth,
    required double maxHeight,
    required double initialSlotSide,
    required double rowGap,
    required double marginH,
    required double marginV,
  }) {
    var slot = initialSlotSide;
    const minSlot = 18.0;
    late ({double width, double height, List<List<Rect>> rows}) geo;
    for (var k = 0; k < 24; k++) {
      geo = layout(
        maxWidth: maxWidth,
        slotSide: slot,
        rowGap: rowGap,
        marginH: marginH,
        marginV: marginV,
      );
      if (geo.height <= maxHeight || slot <= minSlot) {
        return (width: geo.width, height: geo.height, rows: geo.rows, slotSide: slot);
      }
      slot *= 0.92;
    }
    return (width: geo.width, height: geo.height, rows: geo.rows, slotSide: slot);
  }
}
