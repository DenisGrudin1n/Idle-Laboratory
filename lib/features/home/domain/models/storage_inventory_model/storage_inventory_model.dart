import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';

part 'storage_inventory_model.freezed.dart';
part 'storage_inventory_model.g.dart';

@freezed
abstract class StorageInventoryModel with _$StorageInventoryModel {
  const factory StorageInventoryModel({
    @Default({}) Map<ResearchMaterialId, int> inventory,
    @JsonKey(includeToJson: false, includeFromJson: false) ResearchMaterialId? lastAddedMaterial,
    @JsonKey(includeToJson: false, includeFromJson: false) @Default(0) int lastAddedTimestamp,
  }) = _StorageInventoryModel;

  factory StorageInventoryModel.fromJson(Map<String, dynamic> json) =>
      _$StorageInventoryModelFromJson(json);

  factory StorageInventoryModel.empty() => StorageInventoryModel(
        inventory: {
          for (final id in ResearchMaterialId.values) id: 0,
        },
      );
}
