// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cell_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CellModel _$CellModelFromJson(Map<String, dynamic> json) => _CellModel(
  id: json['id'] as String,
  name: $enumDecode(_$CellNameEnumMap, json['name']),
  type: $enumDecode(_$CellTypeEnumMap, json['type']),
  level: (json['level'] as num).toInt(),
  isLocked: json['isLocked'] as bool,
  requiredLevel: (json['requiredLevel'] as num?)?.toInt(),
  energyPerSecond: json['energyPerSecond'] as String?,
);

Map<String, dynamic> _$CellModelToJson(_CellModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': _$CellNameEnumMap[instance.name]!,
      'type': _$CellTypeEnumMap[instance.type]!,
      'level': instance.level,
      'isLocked': instance.isLocked,
      'requiredLevel': instance.requiredLevel,
      'energyPerSecond': instance.energyPerSecond,
    };

const _$CellNameEnumMap = {
  CellName.basicEnergyCell: 'basicEnergyCell',
  CellName.heatCell: 'heatCell',
  CellName.iceCell: 'iceCell',
  CellName.steamCell: 'steamCell',
  CellName.lightCell: 'lightCell',
  CellName.molecularCell: 'molecularCell',
  CellName.bacterialCell: 'bacterialCell',
  CellName.bloodCell: 'bloodCell',
  CellName.bioCell: 'bioCell',
  CellName.radiationCell: 'radiationCell',
  CellName.plasmaCell: 'plasmaCell',
  CellName.darkMatterCell: 'darkMatterCell',
};

const _$CellTypeEnumMap = {CellType.energy: 'energy'};
