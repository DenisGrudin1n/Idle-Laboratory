import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class StorageService {
  StorageService() {
    _init();
  }

  final BehaviorSubject<Map<ResearchMaterialId, int>> _inventorySubject =
      BehaviorSubject<Map<ResearchMaterialId, int>>.seeded({});

  Stream<Map<ResearchMaterialId, int>> get inventory$ => _inventorySubject.stream;
  Map<ResearchMaterialId, int> get currentInventory => _inventorySubject.value;

  void _init() {
    // Initialize with 0 for all materials
    final initialInventory = {
      for (final id in ResearchMaterialId.values) id: 0,
    };
    _inventorySubject.add(initialInventory);
  }

  void addMaterial(ResearchMaterialId materialId, {int count = 1}) {
    final inventory = Map<ResearchMaterialId, int>.from(currentInventory);
    inventory[materialId] = (inventory[materialId] ?? 0) + count;
    _inventorySubject.add(inventory);
  }

  bool hasMaterial(ResearchMaterialId materialId, {int count = 1}) {
    return (currentInventory[materialId] ?? 0) >= count;
  }

  bool trySpendMaterial(ResearchMaterialId materialId, {int count = 1}) {
    if (!hasMaterial(materialId, count: count)) return false;
    
    final inventory = Map<ResearchMaterialId, int>.from(currentInventory);
    inventory[materialId] = inventory[materialId]! - count;
    _inventorySubject.add(inventory);
    return true;
  }

  int getMaterialCount(ResearchMaterialId materialId) {
    return currentInventory[materialId] ?? 0;
  }

  void reset() {
    _init();
  }

  @disposeMethod
  void dispose() {
    _inventorySubject.close();
  }
}
