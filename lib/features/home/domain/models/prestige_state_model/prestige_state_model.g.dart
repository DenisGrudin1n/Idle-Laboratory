// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prestige_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrestigeStateModel _$PrestigeStateModelFromJson(Map<String, dynamic> json) =>
    _PrestigeStateModel(
      totalMultiplier: const BigNumberConverter().fromJson(
        json['totalMultiplier'] as Map<String, dynamic>,
      ),
      currentThreshold: const BigNumberConverter().fromJson(
        json['currentThreshold'] as Map<String, dynamic>,
      ),
      currentMultiplier: const BigNumberConverter().fromJson(
        json['currentMultiplier'] as Map<String, dynamic>,
      ),
      isUnlocked: json['isUnlocked'] as bool,
      prestigeCount: (json['prestigeCount'] as num).toInt(),
    );

Map<String, dynamic> _$PrestigeStateModelToJson(_PrestigeStateModel instance) =>
    <String, dynamic>{
      'totalMultiplier': const BigNumberConverter().toJson(
        instance.totalMultiplier,
      ),
      'currentThreshold': const BigNumberConverter().toJson(
        instance.currentThreshold,
      ),
      'currentMultiplier': const BigNumberConverter().toJson(
        instance.currentMultiplier,
      ),
      'isUnlocked': instance.isUnlocked,
      'prestigeCount': instance.prestigeCount,
    };
