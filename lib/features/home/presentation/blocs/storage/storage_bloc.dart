import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:injectable/injectable.dart';

part 'storage_event.dart';
part 'storage_state.dart';
part 'storage_bloc.freezed.dart';

@injectable
class StorageBloc extends SafeBloc<StorageEvent, StorageState> {
  StorageBloc(this._storageService) : super(const StorageState()) {
    on<_InventoryChanged>((event, emit) => emit(state.copyWith(inventory: event.inventory)));
    _initialize();
  }

  final StorageService _storageService;
  StreamSubscription<Map<ResearchMaterialId, int>>? _inventorySubscription;

  void _initialize() {
    _inventorySubscription = _storageService.inventory$.listen(
      (inventory) => add(StorageEvent.inventoryChanged(inventory)),
    );
  }

  @override
  Future<void> close() async {
    await _inventorySubscription?.cancel();
    return super.close();
  }
}
