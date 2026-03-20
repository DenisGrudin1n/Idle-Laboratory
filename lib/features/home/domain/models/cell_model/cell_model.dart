import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/enums/cell_name.dart';
import 'package:idle_laboratory/core/enums/cell_type.dart';

part 'cell_model.freezed.dart';
part 'cell_model.g.dart';

@freezed
abstract class CellModel with _$CellModel {
  const factory CellModel({
    required String id,
    required CellName name,
    required CellType type,
    required int level,
    required bool isLocked,
    int? requiredLevel,
    String? energyPerSecond,
  }) = _CellModel;

  factory CellModel.fromJson(Map<String, dynamic> json) =>
      _$CellModelFromJson(json);
}
