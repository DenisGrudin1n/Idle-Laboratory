// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cell_production_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CellProductionEntry {

 String get cellId; BigNumber get amount; int get accelerationLevel;
/// Create a copy of CellProductionEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CellProductionEntryCopyWith<CellProductionEntry> get copyWith => _$CellProductionEntryCopyWithImpl<CellProductionEntry>(this as CellProductionEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CellProductionEntry&&(identical(other.cellId, cellId) || other.cellId == cellId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accelerationLevel, accelerationLevel) || other.accelerationLevel == accelerationLevel));
}


@override
int get hashCode => Object.hash(runtimeType,cellId,amount,accelerationLevel);

@override
String toString() {
  return 'CellProductionEntry(cellId: $cellId, amount: $amount, accelerationLevel: $accelerationLevel)';
}


}

/// @nodoc
abstract mixin class $CellProductionEntryCopyWith<$Res>  {
  factory $CellProductionEntryCopyWith(CellProductionEntry value, $Res Function(CellProductionEntry) _then) = _$CellProductionEntryCopyWithImpl;
@useResult
$Res call({
 String cellId, BigNumber amount, int accelerationLevel
});




}
/// @nodoc
class _$CellProductionEntryCopyWithImpl<$Res>
    implements $CellProductionEntryCopyWith<$Res> {
  _$CellProductionEntryCopyWithImpl(this._self, this._then);

  final CellProductionEntry _self;
  final $Res Function(CellProductionEntry) _then;

/// Create a copy of CellProductionEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cellId = null,Object? amount = null,Object? accelerationLevel = null,}) {
  return _then(_self.copyWith(
cellId: null == cellId ? _self.cellId : cellId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as BigNumber,accelerationLevel: null == accelerationLevel ? _self.accelerationLevel : accelerationLevel // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CellProductionEntry].
extension CellProductionEntryPatterns on CellProductionEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CellProductionEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CellProductionEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CellProductionEntry value)  $default,){
final _that = this;
switch (_that) {
case _CellProductionEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CellProductionEntry value)?  $default,){
final _that = this;
switch (_that) {
case _CellProductionEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cellId,  BigNumber amount,  int accelerationLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CellProductionEntry() when $default != null:
return $default(_that.cellId,_that.amount,_that.accelerationLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cellId,  BigNumber amount,  int accelerationLevel)  $default,) {final _that = this;
switch (_that) {
case _CellProductionEntry():
return $default(_that.cellId,_that.amount,_that.accelerationLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cellId,  BigNumber amount,  int accelerationLevel)?  $default,) {final _that = this;
switch (_that) {
case _CellProductionEntry() when $default != null:
return $default(_that.cellId,_that.amount,_that.accelerationLevel);case _:
  return null;

}
}

}

/// @nodoc


class _CellProductionEntry extends CellProductionEntry {
  const _CellProductionEntry({required this.cellId, required this.amount, this.accelerationLevel = 1}): super._();
  

@override final  String cellId;
@override final  BigNumber amount;
@override@JsonKey() final  int accelerationLevel;

/// Create a copy of CellProductionEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CellProductionEntryCopyWith<_CellProductionEntry> get copyWith => __$CellProductionEntryCopyWithImpl<_CellProductionEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CellProductionEntry&&(identical(other.cellId, cellId) || other.cellId == cellId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accelerationLevel, accelerationLevel) || other.accelerationLevel == accelerationLevel));
}


@override
int get hashCode => Object.hash(runtimeType,cellId,amount,accelerationLevel);

@override
String toString() {
  return 'CellProductionEntry(cellId: $cellId, amount: $amount, accelerationLevel: $accelerationLevel)';
}


}

/// @nodoc
abstract mixin class _$CellProductionEntryCopyWith<$Res> implements $CellProductionEntryCopyWith<$Res> {
  factory _$CellProductionEntryCopyWith(_CellProductionEntry value, $Res Function(_CellProductionEntry) _then) = __$CellProductionEntryCopyWithImpl;
@override @useResult
$Res call({
 String cellId, BigNumber amount, int accelerationLevel
});




}
/// @nodoc
class __$CellProductionEntryCopyWithImpl<$Res>
    implements _$CellProductionEntryCopyWith<$Res> {
  __$CellProductionEntryCopyWithImpl(this._self, this._then);

  final _CellProductionEntry _self;
  final $Res Function(_CellProductionEntry) _then;

/// Create a copy of CellProductionEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cellId = null,Object? amount = null,Object? accelerationLevel = null,}) {
  return _then(_CellProductionEntry(
cellId: null == cellId ? _self.cellId : cellId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as BigNumber,accelerationLevel: null == accelerationLevel ? _self.accelerationLevel : accelerationLevel // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
