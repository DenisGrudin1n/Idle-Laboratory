import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/features/home/domain/models/storage_inventory_model/storage_inventory_model.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:injectable/injectable.dart';

part 'storage_event.dart';
part 'storage_state.dart';
part 'storage_bloc.freezed.dart';

@injectable
class StorageBloc extends SafeBloc<StorageEvent, StorageState> {
  StorageBloc(this._storageService) : super(const StorageState()) {
    on<_InventoryChanged>(_onInventoryChanged);
    _initialize();
  }

  final StorageService _storageService;
  StreamSubscription<StorageInventoryModel>? _inventorySubscription;

  void _initialize() {
    _inventorySubscription = _storageService.inventoryModel$.listen(
      (model) => add(StorageEvent.inventoryChanged(model)),
    );
  }

  void _onInventoryChanged(_InventoryChanged event, Emitter<StorageState> emit) {
    emit(state.copyWith(
      inventory: event.model.inventory,
      lastAddedMaterial: event.model.lastAddedMaterial,
      lastAddedTimestamp: event.model.lastAddedTimestamp,
    ));
  }

  @override
  Future<void> close() async {
    await _inventorySubscription?.cancel();
    return super.close();
  }
}
