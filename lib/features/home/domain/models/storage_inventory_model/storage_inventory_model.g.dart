// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_inventory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StorageInventoryModel _$StorageInventoryModelFromJson(
  Map<String, dynamic> json,
) => _StorageInventoryModel(
  inventory:
      (json['inventory'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          $enumDecode(_$ResearchMaterialIdEnumMap, k),
          (e as num).toInt(),
        ),
      ) ??
      const {},
);

Map<String, dynamic> _$StorageInventoryModelToJson(
  _StorageInventoryModel instance,
) => <String, dynamic>{
  'inventory': instance.inventory.map(
    (k, e) => MapEntry(_$ResearchMaterialIdEnumMap[k]!, e),
  ),
};

const _$ResearchMaterialIdEnumMap = {
  ResearchMaterialId.energyCore: 'energyCore',
  ResearchMaterialId.heatShard: 'heatShard',
  ResearchMaterialId.frostCrystal: 'frostCrystal',
  ResearchMaterialId.steamEssence: 'steamEssence',
  ResearchMaterialId.magneticOre: 'magneticOre',
  ResearchMaterialId.lightFragment: 'lightFragment',
  ResearchMaterialId.crystalChunk: 'crystalChunk',
  ResearchMaterialId.molecularGel: 'molecularGel',
  ResearchMaterialId.bacterialSample: 'bacterialSample',
  ResearchMaterialId.dnaStrand: 'dnaStrand',
  ResearchMaterialId.bloodDrop: 'bloodDrop',
  ResearchMaterialId.bioMass: 'bioMass',
  ResearchMaterialId.radiationDust: 'radiationDust',
  ResearchMaterialId.uraniumCore: 'uraniumCore',
  ResearchMaterialId.plasmaOrb: 'plasmaOrb',
  ResearchMaterialId.darkMatterFragment: 'darkMatterFragment',
  ResearchMaterialId.thermalCore: 'thermalCore',
  ResearchMaterialId.phaseCrystal: 'phaseCrystal',
  ResearchMaterialId.photonCore: 'photonCore',
  ResearchMaterialId.structuredMatter: 'structuredMatter',
  ResearchMaterialId.synapticLattice: 'synapticLattice',
  ResearchMaterialId.organicCore: 'organicCore',
  ResearchMaterialId.nuclearMass: 'nuclearMass',
  ResearchMaterialId.voidPlasma: 'voidPlasma',
  ResearchMaterialId.entropyCore: 'entropyCore',
  ResearchMaterialId.quantumMatrix: 'quantumMatrix',
  ResearchMaterialId.primalOrganism: 'primalOrganism',
  ResearchMaterialId.annihilationCore: 'annihilationCore',
  ResearchMaterialId.realityEngine: 'realityEngine',
  ResearchMaterialId.abyssalHeart: 'abyssalHeart',
  ResearchMaterialId.bloodstoneOfDominion: 'bloodstoneOfDominion',
};
