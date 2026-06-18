import 'dart:async';

import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/features/home/data/repositories/storage_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/storage_inventory_model/storage_inventory_model.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class StorageService {
  StorageService(this._storageRepository) {
    _init();
  }

  final StorageRepository _storageRepository;

  final BehaviorSubject<StorageInventoryModel> _inventorySubject =
      BehaviorSubject<StorageInventoryModel>();

  Stream<StorageInventoryModel> get inventoryModel$ => _inventorySubject.stream;
  Stream<Map<ResearchMaterialId, int>> get inventory$ =>
      _inventorySubject.stream.map((model) => model.inventory);
  Map<ResearchMaterialId, int> get currentInventory => _inventorySubject.value.inventory;

  Timer? _saveTimer;
  StorageInventoryModel? _pendingInventoryToSave;

  Future<void> _init() async {
    final savedModel = await _storageRepository.getSavedInventory();
    _inventorySubject.add(savedModel ?? StorageInventoryModel.empty());
  }

  void addMaterial(ResearchMaterialId materialId, {int count = 1}) {
    final inventory = Map<ResearchMaterialId, int>.from(currentInventory);
    inventory[materialId] = (inventory[materialId] ?? 0) + count;

    final updatedModel = _inventorySubject.value.copyWith(
      inventory: inventory,
      lastAddedMaterial: materialId,
      lastAddedTimestamp: DateTime.now().millisecondsSinceEpoch,
    );
    _inventorySubject.add(updatedModel);
    _saveInventoryThrottled(updatedModel);
  }

  bool hasMaterial(ResearchMaterialId materialId, {int count = 1}) {
    return (currentInventory[materialId] ?? 0) >= count;
  }

  bool trySpendMaterial(ResearchMaterialId materialId, {int count = 1}) {
    if (!hasMaterial(materialId, count: count)) return false;

    final inventory = Map<ResearchMaterialId, int>.from(currentInventory);
    inventory[materialId] = inventory[materialId]! - count;
    
    final updatedModel = _inventorySubject.value.copyWith(inventory: inventory);
    _inventorySubject.add(updatedModel);
    _saveInventoryThrottled(updatedModel);
    return true;
  }

  int getMaterialCount(ResearchMaterialId materialId) {
    return currentInventory[materialId] ?? 0;
  }

  void _saveInventoryThrottled(StorageInventoryModel model) {
    _pendingInventoryToSave = model;
    if (_saveTimer != null) return;

    _saveTimer = Timer(const Duration(milliseconds: GameBalance.energyAutoSaveDurationMs), () {
      if (_pendingInventoryToSave != null) {
        _storageRepository.saveInventory(_pendingInventoryToSave!);
        _pendingInventoryToSave = null;
      }
      _saveTimer = null;
    });
  }

  void saveInventory() {
    if (_pendingInventoryToSave != null) {
      _storageRepository.saveInventory(_pendingInventoryToSave!);
      _pendingInventoryToSave = null;
      _saveTimer?.cancel();
      _saveTimer = null;
    }
  }

  void reset() {
    final emptyModel = StorageInventoryModel.empty();
    _inventorySubject.add(emptyModel);
    _storageRepository.saveInventory(emptyModel);
  }

  @disposeMethod
  void dispose() {
    saveInventory();
    _saveTimer?.cancel();
    _inventorySubject.close();
  }
}
