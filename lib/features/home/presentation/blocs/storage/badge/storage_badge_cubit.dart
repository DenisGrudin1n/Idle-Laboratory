import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:injectable/injectable.dart';

part 'storage_badge_state.dart';
part 'storage_badge_cubit.freezed.dart';

@injectable
class StorageBadgeCubit extends Cubit<StorageBadgeState> {
  StorageBadgeCubit() : super(const StorageBadgeState());

  void showMaterial(ResearchMaterialId materialId, int timestamp) {
    emit(state.copyWith(
      materialId: materialId,
      timestamp: timestamp,
    ));
  }
}
