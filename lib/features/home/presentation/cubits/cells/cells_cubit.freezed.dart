// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cells_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CellsState {

 List<CellModel> get cells; BigNumber? get totalEnergy; String? get selectedCellId;/// Per-cell dedicated energy for level progression (separate from totalEnergy)
 Map<String, BigNumber> get cellEnergies;
/// Create a copy of CellsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CellsStateCopyWith<CellsState> get copyWith => _$CellsStateCopyWithImpl<CellsState>(this as CellsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CellsState&&const DeepCollectionEquality().equals(other.cells, cells)&&(identical(other.totalEnergy, totalEnergy) || other.totalEnergy == totalEnergy)&&(identical(other.selectedCellId, selectedCellId) || other.selectedCellId == selectedCellId)&&const DeepCollectionEquality().equals(other.cellEnergies, cellEnergies));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cells),totalEnergy,selectedCellId,const DeepCollectionEquality().hash(cellEnergies));

@override
String toString() {
  return 'CellsState(cells: $cells, totalEnergy: $totalEnergy, selectedCellId: $selectedCellId, cellEnergies: $cellEnergies)';
}


}

/// @nodoc
abstract mixin class $CellsStateCopyWith<$Res>  {
  factory $CellsStateCopyWith(CellsState value, $Res Function(CellsState) _then) = _$CellsStateCopyWithImpl;
@useResult
$Res call({
 List<CellModel> cells, BigNumber? totalEnergy, String? selectedCellId, Map<String, BigNumber> cellEnergies
});




}
/// @nodoc
class _$CellsStateCopyWithImpl<$Res>
    implements $CellsStateCopyWith<$Res> {
  _$CellsStateCopyWithImpl(this._self, this._then);

  final CellsState _self;
  final $Res Function(CellsState) _then;

/// Create a copy of CellsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cells = null,Object? totalEnergy = freezed,Object? selectedCellId = freezed,Object? cellEnergies = null,}) {
  return _then(_self.copyWith(
cells: null == cells ? _self.cells : cells // ignore: cast_nullable_to_non_nullable
as List<CellModel>,totalEnergy: freezed == totalEnergy ? _self.totalEnergy : totalEnergy // ignore: cast_nullable_to_non_nullable
as BigNumber?,selectedCellId: freezed == selectedCellId ? _self.selectedCellId : selectedCellId // ignore: cast_nullable_to_non_nullable
as String?,cellEnergies: null == cellEnergies ? _self.cellEnergies : cellEnergies // ignore: cast_nullable_to_non_nullable
as Map<String, BigNumber>,
  ));
}

}


/// Adds pattern-matching-related methods to [CellsState].
extension CellsStatePatterns on CellsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CellsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CellsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CellsState value)  $default,){
final _that = this;
switch (_that) {
case _CellsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CellsState value)?  $default,){
final _that = this;
switch (_that) {
case _CellsState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CellModel> cells,  BigNumber? totalEnergy,  String? selectedCellId,  Map<String, BigNumber> cellEnergies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CellsState() when $default != null:
return $default(_that.cells,_that.totalEnergy,_that.selectedCellId,_that.cellEnergies);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CellModel> cells,  BigNumber? totalEnergy,  String? selectedCellId,  Map<String, BigNumber> cellEnergies)  $default,) {final _that = this;
switch (_that) {
case _CellsState():
return $default(_that.cells,_that.totalEnergy,_that.selectedCellId,_that.cellEnergies);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CellModel> cells,  BigNumber? totalEnergy,  String? selectedCellId,  Map<String, BigNumber> cellEnergies)?  $default,) {final _that = this;
switch (_that) {
case _CellsState() when $default != null:
return $default(_that.cells,_that.totalEnergy,_that.selectedCellId,_that.cellEnergies);case _:
  return null;

}
}

}

/// @nodoc


class _CellsState implements CellsState {
  const _CellsState({final  List<CellModel> cells = const <CellModel>[], this.totalEnergy, this.selectedCellId, final  Map<String, BigNumber> cellEnergies = const <String, BigNumber>{}}): _cells = cells,_cellEnergies = cellEnergies;
  

 final  List<CellModel> _cells;
@override@JsonKey() List<CellModel> get cells {
  if (_cells is EqualUnmodifiableListView) return _cells;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cells);
}

@override final  BigNumber? totalEnergy;
@override final  String? selectedCellId;
/// Per-cell dedicated energy for level progression (separate from totalEnergy)
 final  Map<String, BigNumber> _cellEnergies;
/// Per-cell dedicated energy for level progression (separate from totalEnergy)
@override@JsonKey() Map<String, BigNumber> get cellEnergies {
  if (_cellEnergies is EqualUnmodifiableMapView) return _cellEnergies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_cellEnergies);
}


/// Create a copy of CellsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CellsStateCopyWith<_CellsState> get copyWith => __$CellsStateCopyWithImpl<_CellsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CellsState&&const DeepCollectionEquality().equals(other._cells, _cells)&&(identical(other.totalEnergy, totalEnergy) || other.totalEnergy == totalEnergy)&&(identical(other.selectedCellId, selectedCellId) || other.selectedCellId == selectedCellId)&&const DeepCollectionEquality().equals(other._cellEnergies, _cellEnergies));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cells),totalEnergy,selectedCellId,const DeepCollectionEquality().hash(_cellEnergies));

@override
String toString() {
  return 'CellsState(cells: $cells, totalEnergy: $totalEnergy, selectedCellId: $selectedCellId, cellEnergies: $cellEnergies)';
}


}

/// @nodoc
abstract mixin class _$CellsStateCopyWith<$Res> implements $CellsStateCopyWith<$Res> {
  factory _$CellsStateCopyWith(_CellsState value, $Res Function(_CellsState) _then) = __$CellsStateCopyWithImpl;
@override @useResult
$Res call({
 List<CellModel> cells, BigNumber? totalEnergy, String? selectedCellId, Map<String, BigNumber> cellEnergies
});




}
/// @nodoc
class __$CellsStateCopyWithImpl<$Res>
    implements _$CellsStateCopyWith<$Res> {
  __$CellsStateCopyWithImpl(this._self, this._then);

  final _CellsState _self;
  final $Res Function(_CellsState) _then;

/// Create a copy of CellsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cells = null,Object? totalEnergy = freezed,Object? selectedCellId = freezed,Object? cellEnergies = null,}) {
  return _then(_CellsState(
cells: null == cells ? _self._cells : cells // ignore: cast_nullable_to_non_nullable
as List<CellModel>,totalEnergy: freezed == totalEnergy ? _self.totalEnergy : totalEnergy // ignore: cast_nullable_to_non_nullable
as BigNumber?,selectedCellId: freezed == selectedCellId ? _self.selectedCellId : selectedCellId // ignore: cast_nullable_to_non_nullable
as String?,cellEnergies: null == cellEnergies ? _self._cellEnergies : cellEnergies // ignore: cast_nullable_to_non_nullable
as Map<String, BigNumber>,
  ));
}


}

// dart format on
