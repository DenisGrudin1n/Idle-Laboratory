// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_badge_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StorageBadgeState {

 ResearchMaterialId? get materialId; int get timestamp;
/// Create a copy of StorageBadgeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageBadgeStateCopyWith<StorageBadgeState> get copyWith => _$StorageBadgeStateCopyWithImpl<StorageBadgeState>(this as StorageBadgeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageBadgeState&&(identical(other.materialId, materialId) || other.materialId == materialId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,materialId,timestamp);

@override
String toString() {
  return 'StorageBadgeState(materialId: $materialId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $StorageBadgeStateCopyWith<$Res>  {
  factory $StorageBadgeStateCopyWith(StorageBadgeState value, $Res Function(StorageBadgeState) _then) = _$StorageBadgeStateCopyWithImpl;
@useResult
$Res call({
 ResearchMaterialId? materialId, int timestamp
});




}
/// @nodoc
class _$StorageBadgeStateCopyWithImpl<$Res>
    implements $StorageBadgeStateCopyWith<$Res> {
  _$StorageBadgeStateCopyWithImpl(this._self, this._then);

  final StorageBadgeState _self;
  final $Res Function(StorageBadgeState) _then;

/// Create a copy of StorageBadgeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? materialId = freezed,Object? timestamp = null,}) {
  return _then(_self.copyWith(
materialId: freezed == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as ResearchMaterialId?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StorageBadgeState].
extension StorageBadgeStatePatterns on StorageBadgeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorageBadgeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorageBadgeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorageBadgeState value)  $default,){
final _that = this;
switch (_that) {
case _StorageBadgeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorageBadgeState value)?  $default,){
final _that = this;
switch (_that) {
case _StorageBadgeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ResearchMaterialId? materialId,  int timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorageBadgeState() when $default != null:
return $default(_that.materialId,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ResearchMaterialId? materialId,  int timestamp)  $default,) {final _that = this;
switch (_that) {
case _StorageBadgeState():
return $default(_that.materialId,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ResearchMaterialId? materialId,  int timestamp)?  $default,) {final _that = this;
switch (_that) {
case _StorageBadgeState() when $default != null:
return $default(_that.materialId,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _StorageBadgeState implements StorageBadgeState {
  const _StorageBadgeState({this.materialId, this.timestamp = 0});
  

@override final  ResearchMaterialId? materialId;
@override@JsonKey() final  int timestamp;

/// Create a copy of StorageBadgeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorageBadgeStateCopyWith<_StorageBadgeState> get copyWith => __$StorageBadgeStateCopyWithImpl<_StorageBadgeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorageBadgeState&&(identical(other.materialId, materialId) || other.materialId == materialId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,materialId,timestamp);

@override
String toString() {
  return 'StorageBadgeState(materialId: $materialId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$StorageBadgeStateCopyWith<$Res> implements $StorageBadgeStateCopyWith<$Res> {
  factory _$StorageBadgeStateCopyWith(_StorageBadgeState value, $Res Function(_StorageBadgeState) _then) = __$StorageBadgeStateCopyWithImpl;
@override @useResult
$Res call({
 ResearchMaterialId? materialId, int timestamp
});




}
/// @nodoc
class __$StorageBadgeStateCopyWithImpl<$Res>
    implements _$StorageBadgeStateCopyWith<$Res> {
  __$StorageBadgeStateCopyWithImpl(this._self, this._then);

  final _StorageBadgeState _self;
  final $Res Function(_StorageBadgeState) _then;

/// Create a copy of StorageBadgeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? materialId = freezed,Object? timestamp = null,}) {
  return _then(_StorageBadgeState(
materialId: freezed == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as ResearchMaterialId?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
