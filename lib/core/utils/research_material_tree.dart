import 'package:idle_laboratory/core/enums/research_material_id.dart';

/// Binary merge tree: pair `(2k, 2k+1)` at one tier → parent at the next tier.
abstract final class ResearchMaterialTree {
  ResearchMaterialTree._();

  static const tierSizesBottomToTop = [16, 8, 4, 2, 1];
  static const totalCount = 31;

  static int _baseIndexForTierFromBottom(int tierFromBottom) {
    var base = 0;
    for (var r = 0; r < tierFromBottom; r++) {
      base += tierSizesBottomToTop[r];
    }
    return base;
  }

  /// [rowFromTop] = 0 apex … 4 bottom; [slotIndex] = 0..n-1 in that row.
  static int materialIndexForSlot({required int rowFromTop, required int slotIndex}) {
    final tierFromBottom = 4 - rowFromTop;
    final base = _baseIndexForTierFromBottom(tierFromBottom);
    return base + slotIndex;
  }

  static ResearchMaterialId idForSlot({required int rowFromTop, required int slotIndex}) =>
      ResearchMaterialId.values[materialIndexForSlot(rowFromTop: rowFromTop, slotIndex: slotIndex)];

  /// Direct parent in merge tree; `null` for apex.
  static int? parentIndex(int materialIndex) {
    if (materialIndex < 0 || materialIndex >= totalCount) return null;
    if (materialIndex >= 28) return materialIndex == 30 ? null : 30;
    if (materialIndex >= 24) return 28 + (materialIndex - 24) ~/ 2;
    if (materialIndex >= 16) return 24 + (materialIndex - 16) ~/ 2;
    return 16 + materialIndex ~/ 2;
  }

  /// Two children when this tier merges downward; `null` for bottom tier (leaves).
  static (int left, int right)? childIndices(int materialIndex) {
    if (materialIndex < 16) return null;
    if (materialIndex < 24) {
      final k = materialIndex - 16;
      return (2 * k, 2 * k + 1);
    }
    if (materialIndex < 28) {
      final k = materialIndex - 24;
      return (16 + 2 * k, 16 + 2 * k + 1);
    }
    if (materialIndex < 30) {
      final k = materialIndex - 28;
      return (24 + 2 * k, 24 + 2 * k + 1);
    }
    if (materialIndex == 30) return (28, 29);
    return null;
  }
}
