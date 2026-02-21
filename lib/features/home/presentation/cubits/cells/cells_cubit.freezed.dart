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

 List<CellModel> get availableCells; String? get selectedCellId;
/// Create a copy of CellsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CellsStateCopyWith<CellsState> get copyWith => _$CellsStateCopyWithImpl<CellsState>(this as CellsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CellsState&&const DeepCollectionEquality().equals(other.availableCells, availableCells)&&(identical(other.selectedCellId, selectedCellId) || other.selectedCellId == selectedCellId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(availableCells),selectedCellId);

@override
String toString() {
  return 'CellsState(availableCells: $availableCells, selectedCellId: $selectedCellId)';
}


}

/// @nodoc
abstract mixin class $CellsStateCopyWith<$Res>  {
  factory $CellsStateCopyWith(CellsState value, $Res Function(CellsState) _then) = _$CellsStateCopyWithImpl;
@useResult
$Res call({
 List<CellModel> availableCells, String? selectedCellId
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
@pragma('vm:prefer-inline') @override $Res call({Object? availableCells = null,Object? selectedCellId = freezed,}) {
  return _then(_self.copyWith(
availableCells: null == availableCells ? _self.availableCells : availableCells // ignore: cast_nullable_to_non_nullable
as List<CellModel>,selectedCellId: freezed == selectedCellId ? _self.selectedCellId : selectedCellId // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CellModel> availableCells,  String? selectedCellId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CellsState() when $default != null:
return $default(_that.availableCells,_that.selectedCellId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CellModel> availableCells,  String? selectedCellId)  $default,) {final _that = this;
switch (_that) {
case _CellsState():
return $default(_that.availableCells,_that.selectedCellId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CellModel> availableCells,  String? selectedCellId)?  $default,) {final _that = this;
switch (_that) {
case _CellsState() when $default != null:
return $default(_that.availableCells,_that.selectedCellId);case _:
  return null;

}
}

}

/// @nodoc


class _CellsState implements CellsState {
  const _CellsState({final  List<CellModel> availableCells = const <CellModel>[], this.selectedCellId}): _availableCells = availableCells;
  

 final  List<CellModel> _availableCells;
@override@JsonKey() List<CellModel> get availableCells {
  if (_availableCells is EqualUnmodifiableListView) return _availableCells;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableCells);
}

@override final  String? selectedCellId;

/// Create a copy of CellsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CellsStateCopyWith<_CellsState> get copyWith => __$CellsStateCopyWithImpl<_CellsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CellsState&&const DeepCollectionEquality().equals(other._availableCells, _availableCells)&&(identical(other.selectedCellId, selectedCellId) || other.selectedCellId == selectedCellId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_availableCells),selectedCellId);

@override
String toString() {
  return 'CellsState(availableCells: $availableCells, selectedCellId: $selectedCellId)';
}


}

/// @nodoc
abstract mixin class _$CellsStateCopyWith<$Res> implements $CellsStateCopyWith<$Res> {
  factory _$CellsStateCopyWith(_CellsState value, $Res Function(_CellsState) _then) = __$CellsStateCopyWithImpl;
@override @useResult
$Res call({
 List<CellModel> availableCells, String? selectedCellId
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
@override @pragma('vm:prefer-inline') $Res call({Object? availableCells = null,Object? selectedCellId = freezed,}) {
  return _then(_CellsState(
availableCells: null == availableCells ? _self._availableCells : availableCells // ignore: cast_nullable_to_non_nullable
as List<CellModel>,selectedCellId: freezed == selectedCellId ? _self.selectedCellId : selectedCellId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
