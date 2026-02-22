// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cell_level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CellLevelModel _$CellLevelModelFromJson(Map<String, dynamic> json) =>
    _CellLevelModel(
      level: (json['level'] as num).toInt(),
      energyRequired: const BigNumberConverter().fromJson(
        json['energyRequired'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$CellLevelModelToJson(
  _CellLevelModel instance,
) => <String, dynamic>{
  'level': instance.level,
  'energyRequired': const BigNumberConverter().toJson(instance.energyRequired),
};
