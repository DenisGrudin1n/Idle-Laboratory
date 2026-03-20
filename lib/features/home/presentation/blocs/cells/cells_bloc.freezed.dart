// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cells_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CellsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CellsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CellsEvent()';
}


}

/// @nodoc
class $CellsEventCopyWith<$Res>  {
$CellsEventCopyWith(CellsEvent _, $Res Function(CellsEvent) __);
}


/// Adds pattern-matching-related methods to [CellsEvent].
extension CellsEventPatterns on CellsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CellsChanged value)?  cellsChanged,TResult Function( _CellEnergiesChanged value)?  cellEnergiesChanged,TResult Function( _TotalEnergyChanged value)?  totalEnergyChanged,TResult Function( _SelectCell value)?  selectCell,TResult Function( _Start value)?  start,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CellsChanged() when cellsChanged != null:
return cellsChanged(_that);case _CellEnergiesChanged() when cellEnergiesChanged != null:
return cellEnergiesChanged(_that);case _TotalEnergyChanged() when totalEnergyChanged != null:
return totalEnergyChanged(_that);case _SelectCell() when selectCell != null:
return selectCell(_that);case _Start() when start != null:
return start(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CellsChanged value)  cellsChanged,required TResult Function( _CellEnergiesChanged value)  cellEnergiesChanged,required TResult Function( _TotalEnergyChanged value)  totalEnergyChanged,required TResult Function( _SelectCell value)  selectCell,required TResult Function( _Start value)  start,}){
final _that = this;
switch (_that) {
case _CellsChanged():
return cellsChanged(_that);case _CellEnergiesChanged():
return cellEnergiesChanged(_that);case _TotalEnergyChanged():
return totalEnergyChanged(_that);case _SelectCell():
return selectCell(_that);case _Start():
return start(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CellsChanged value)?  cellsChanged,TResult? Function( _CellEnergiesChanged value)?  cellEnergiesChanged,TResult? Function( _TotalEnergyChanged value)?  totalEnergyChanged,TResult? Function( _SelectCell value)?  selectCell,TResult? Function( _Start value)?  start,}){
final _that = this;
switch (_that) {
case _CellsChanged() when cellsChanged != null:
return cellsChanged(_that);case _CellEnergiesChanged() when cellEnergiesChanged != null:
return cellEnergiesChanged(_that);case _TotalEnergyChanged() when totalEnergyChanged != null:
return totalEnergyChanged(_that);case _SelectCell() when selectCell != null:
return selectCell(_that);case _Start() when start != null:
return start(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<CellModel> cells)?  cellsChanged,TResult Function( Map<String, BigNumber> cellEnergies)?  cellEnergiesChanged,TResult Function( BigNumber energy)?  totalEnergyChanged,TResult Function( String cellId)?  selectCell,TResult Function()?  start,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CellsChanged() when cellsChanged != null:
return cellsChanged(_that.cells);case _CellEnergiesChanged() when cellEnergiesChanged != null:
return cellEnergiesChanged(_that.cellEnergies);case _TotalEnergyChanged() when totalEnergyChanged != null:
return totalEnergyChanged(_that.energy);case _SelectCell() when selectCell != null:
return selectCell(_that.cellId);case _Start() when start != null:
return start();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<CellModel> cells)  cellsChanged,required TResult Function( Map<String, BigNumber> cellEnergies)  cellEnergiesChanged,required TResult Function( BigNumber energy)  totalEnergyChanged,required TResult Function( String cellId)  selectCell,required TResult Function()  start,}) {final _that = this;
switch (_that) {
case _CellsChanged():
return cellsChanged(_that.cells);case _CellEnergiesChanged():
return cellEnergiesChanged(_that.cellEnergies);case _TotalEnergyChanged():
return totalEnergyChanged(_that.energy);case _SelectCell():
return selectCell(_that.cellId);case _Start():
return start();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<CellModel> cells)?  cellsChanged,TResult? Function( Map<String, BigNumber> cellEnergies)?  cellEnergiesChanged,TResult? Function( BigNumber energy)?  totalEnergyChanged,TResult? Function( String cellId)?  selectCell,TResult? Function()?  start,}) {final _that = this;
switch (_that) {
case _CellsChanged() when cellsChanged != null:
return cellsChanged(_that.cells);case _CellEnergiesChanged() when cellEnergiesChanged != null:
return cellEnergiesChanged(_that.cellEnergies);case _TotalEnergyChanged() when totalEnergyChanged != null:
return totalEnergyChanged(_that.energy);case _SelectCell() when selectCell != null:
return selectCell(_that.cellId);case _Start() when start != null:
return start();case _:
  return null;

}
}

}

/// @nodoc


class _CellsChanged implements CellsEvent {
  const _CellsChanged(final  List<CellModel> cells): _cells = cells;
  

 final  List<CellModel> _cells;
 List<CellModel> get cells {
  if (_cells is EqualUnmodifiableListView) return _cells;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cells);
}


/// Create a copy of CellsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CellsChangedCopyWith<_CellsChanged> get copyWith => __$CellsChangedCopyWithImpl<_CellsChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CellsChanged&&const DeepCollectionEquality().equals(other._cells, _cells));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cells));

@override
String toString() {
  return 'CellsEvent.cellsChanged(cells: $cells)';
}


}

/// @nodoc
abstract mixin class _$CellsChangedCopyWith<$Res> implements $CellsEventCopyWith<$Res> {
  factory _$CellsChangedCopyWith(_CellsChanged value, $Res Function(_CellsChanged) _then) = __$CellsChangedCopyWithImpl;
@useResult
$Res call({
 List<CellModel> cells
});




}
/// @nodoc
class __$CellsChangedCopyWithImpl<$Res>
    implements _$CellsChangedCopyWith<$Res> {
  __$CellsChangedCopyWithImpl(this._self, this._then);

  final _CellsChanged _self;
  final $Res Function(_CellsChanged) _then;

/// Create a copy of CellsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cells = null,}) {
  return _then(_CellsChanged(
null == cells ? _self._cells : cells // ignore: cast_nullable_to_non_nullable
as List<CellModel>,
  ));
}


}

/// @nodoc


class _CellEnergiesChanged implements CellsEvent {
  const _CellEnergiesChanged(final  Map<String, BigNumber> cellEnergies): _cellEnergies = cellEnergies;
  

 final  Map<String, BigNumber> _cellEnergies;
 Map<String, BigNumber> get cellEnergies {
  if (_cellEnergies is EqualUnmodifiableMapView) return _cellEnergies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_cellEnergies);
}


/// Create a copy of CellsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CellEnergiesChangedCopyWith<_CellEnergiesChanged> get copyWith => __$CellEnergiesChangedCopyWithImpl<_CellEnergiesChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CellEnergiesChanged&&const DeepCollectionEquality().equals(other._cellEnergies, _cellEnergies));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cellEnergies));

@override
String toString() {
  return 'CellsEvent.cellEnergiesChanged(cellEnergies: $cellEnergies)';
}


}

/// @nodoc
abstract mixin class _$CellEnergiesChangedCopyWith<$Res> implements $CellsEventCopyWith<$Res> {
  factory _$CellEnergiesChangedCopyWith(_CellEnergiesChanged value, $Res Function(_CellEnergiesChanged) _then) = __$CellEnergiesChangedCopyWithImpl;
@useResult
$Res call({
 Map<String, BigNumber> cellEnergies
});




}
/// @nodoc
class __$CellEnergiesChangedCopyWithImpl<$Res>
    implements _$CellEnergiesChangedCopyWith<$Res> {
  __$CellEnergiesChangedCopyWithImpl(this._self, this._then);

  final _CellEnergiesChanged _self;
  final $Res Function(_CellEnergiesChanged) _then;

/// Create a copy of CellsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cellEnergies = null,}) {
  return _then(_CellEnergiesChanged(
null == cellEnergies ? _self._cellEnergies : cellEnergies // ignore: cast_nullable_to_non_nullable
as Map<String, BigNumber>,
  ));
}


}

/// @nodoc


class _TotalEnergyChanged implements CellsEvent {
  const _TotalEnergyChanged(this.energy);
  

 final  BigNumber energy;

/// Create a copy of CellsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TotalEnergyChangedCopyWith<_TotalEnergyChanged> get copyWith => __$TotalEnergyChangedCopyWithImpl<_TotalEnergyChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TotalEnergyChanged&&(identical(other.energy, energy) || other.energy == energy));
}


@override
int get hashCode => Object.hash(runtimeType,energy);

@override
String toString() {
  return 'CellsEvent.totalEnergyChanged(energy: $energy)';
}


}

/// @nodoc
abstract mixin class _$TotalEnergyChangedCopyWith<$Res> implements $CellsEventCopyWith<$Res> {
  factory _$TotalEnergyChangedCopyWith(_TotalEnergyChanged value, $Res Function(_TotalEnergyChanged) _then) = __$TotalEnergyChangedCopyWithImpl;
@useResult
$Res call({
 BigNumber energy
});




}
/// @nodoc
class __$TotalEnergyChangedCopyWithImpl<$Res>
    implements _$TotalEnergyChangedCopyWith<$Res> {
  __$TotalEnergyChangedCopyWithImpl(this._self, this._then);

  final _TotalEnergyChanged _self;
  final $Res Function(_TotalEnergyChanged) _then;

/// Create a copy of CellsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? energy = null,}) {
  return _then(_TotalEnergyChanged(
null == energy ? _self.energy : energy // ignore: cast_nullable_to_non_nullable
as BigNumber,
  ));
}


}

/// @nodoc


class _SelectCell implements CellsEvent {
  const _SelectCell(this.cellId);
  

 final  String cellId;

/// Create a copy of CellsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectCellCopyWith<_SelectCell> get copyWith => __$SelectCellCopyWithImpl<_SelectCell>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectCell&&(identical(other.cellId, cellId) || other.cellId == cellId));
}


@override
int get hashCode => Object.hash(runtimeType,cellId);

@override
String toString() {
  return 'CellsEvent.selectCell(cellId: $cellId)';
}


}

/// @nodoc
abstract mixin class _$SelectCellCopyWith<$Res> implements $CellsEventCopyWith<$Res> {
  factory _$SelectCellCopyWith(_SelectCell value, $Res Function(_SelectCell) _then) = __$SelectCellCopyWithImpl;
@useResult
$Res call({
 String cellId
});




}
/// @nodoc
class __$SelectCellCopyWithImpl<$Res>
    implements _$SelectCellCopyWith<$Res> {
  __$SelectCellCopyWithImpl(this._self, this._then);

  final _SelectCell _self;
  final $Res Function(_SelectCell) _then;

/// Create a copy of CellsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cellId = null,}) {
  return _then(_SelectCell(
null == cellId ? _self.cellId : cellId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Start implements CellsEvent {
  const _Start();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Start);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CellsEvent.start()';
}


}




/// @nodoc
mixin _$CellsState {

 List<CellModel> get cells; BigNumber? get totalEnergy; String? get selectedCellId; Map<String, BigNumber> get cellEnergies;
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
 final  Map<String, BigNumber> _cellEnergies;
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
