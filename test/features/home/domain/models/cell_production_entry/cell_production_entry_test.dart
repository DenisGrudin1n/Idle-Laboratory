import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_production_entry/cell_production_entry.dart';

void main() {
  group('CellProductionEntry', () {
    test('initial factory creates zero amount entry', () {
      const cellId = 'basic_energy_cell';
      final entry = CellProductionEntry.initial(cellId);

      expect(entry.cellId, cellId);
      expect(entry.amount, BigNumber.zero());
      expect(entry.accelerationLevel, 1);
    });

    test('fromJson reads compact persisted format', () {
      final entry = CellProductionEntry.fromJson({
        'i': 'heat_cell',
        'm': 12.5,
        'e': 3,
        'a': 4,
      });

      expect(entry.cellId, 'heat_cell');
      expect(entry.amount, BigNumber(12.5, 3));
      expect(entry.accelerationLevel, 4);
    });

    test('fromJson clamps acceleration level to game max', () {
      final entry = CellProductionEntry.fromJson({
        'i': 'heat_cell',
        'm': 0,
        'e': 0,
        'a': 999,
      });

      expect(entry.accelerationLevel, GameBalance.maxAccelerationLevel);
    });

    test('toJson writes compact persisted format', () {
      final entry = CellProductionEntry(
        cellId: 'ice_cell',
        amount: BigNumber(7, 2),
        accelerationLevel: 2,
      );

      expect(entry.toJson(), {
        'i': 'ice_cell',
        'm': 7.0,
        'e': 2,
        'a': 2,
      });
    });

    test('copyWith preserves unchanged fields', () {
      final original = CellProductionEntry(
        cellId: 'steam_cell',
        amount: BigNumber(1, 0),
        accelerationLevel: 3,
      );

      final updated = original.copyWith(amount: BigNumber(5, 1));

      expect(updated.cellId, original.cellId);
      expect(updated.amount, BigNumber(5, 1));
      expect(updated.accelerationLevel, 3);
    });

    test('equality compares all fields', () {
      final a = CellProductionEntry(
        cellId: 'steam_cell',
        amount: BigNumber(1, 0),
        accelerationLevel: 3,
      );
      final b = a.copyWith();
      final c = a.copyWith(amount: BigNumber(2, 0));

      expect(a, b);
      expect(a, isNot(c));
    });
  });
}
