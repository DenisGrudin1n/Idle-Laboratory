import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/utils/big_number_converter.dart';

part 'cell_level_model.freezed.dart';
part 'cell_level_model.g.dart';

@freezed
abstract class CellLevelModel with _$CellLevelModel {
  const factory CellLevelModel({
    required int level,
    @BigNumberConverter() required BigNumber energyRequired,
  }) = _CellLevelModel;

  factory CellLevelModel.fromJson(Map<String, dynamic> json) => _$CellLevelModelFromJson(json);
}
