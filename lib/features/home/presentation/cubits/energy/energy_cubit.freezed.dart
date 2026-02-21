// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'energy_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EnergyState {

 BigNumber get currentEnergy; BigNumber get energyPerSecond;
/// Create a copy of EnergyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnergyStateCopyWith<EnergyState> get copyWith => _$EnergyStateCopyWithImpl<EnergyState>(this as EnergyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnergyState&&(identical(other.currentEnergy, currentEnergy) || other.currentEnergy == currentEnergy)&&(identical(other.energyPerSecond, energyPerSecond) || other.energyPerSecond == energyPerSecond));
}


@override
int get hashCode => Object.hash(runtimeType,currentEnergy,energyPerSecond);

@override
String toString() {
  return 'EnergyState(currentEnergy: $currentEnergy, energyPerSecond: $energyPerSecond)';
}


}

/// @nodoc
abstract mixin class $EnergyStateCopyWith<$Res>  {
  factory $EnergyStateCopyWith(EnergyState value, $Res Function(EnergyState) _then) = _$EnergyStateCopyWithImpl;
@useResult
$Res call({
 BigNumber currentEnergy, BigNumber energyPerSecond
});




}
/// @nodoc
class _$EnergyStateCopyWithImpl<$Res>
    implements $EnergyStateCopyWith<$Res> {
  _$EnergyStateCopyWithImpl(this._self, this._then);

  final EnergyState _self;
  final $Res Function(EnergyState) _then;

/// Create a copy of EnergyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentEnergy = null,Object? energyPerSecond = null,}) {
  return _then(_self.copyWith(
currentEnergy: null == currentEnergy ? _self.currentEnergy : currentEnergy // ignore: cast_nullable_to_non_nullable
as BigNumber,energyPerSecond: null == energyPerSecond ? _self.energyPerSecond : energyPerSecond // ignore: cast_nullable_to_non_nullable
as BigNumber,
  ));
}

}


/// Adds pattern-matching-related methods to [EnergyState].
extension EnergyStatePatterns on EnergyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnergyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnergyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnergyState value)  $default,){
final _that = this;
switch (_that) {
case _EnergyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnergyState value)?  $default,){
final _that = this;
switch (_that) {
case _EnergyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BigNumber currentEnergy,  BigNumber energyPerSecond)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnergyState() when $default != null:
return $default(_that.currentEnergy,_that.energyPerSecond);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BigNumber currentEnergy,  BigNumber energyPerSecond)  $default,) {final _that = this;
switch (_that) {
case _EnergyState():
return $default(_that.currentEnergy,_that.energyPerSecond);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BigNumber currentEnergy,  BigNumber energyPerSecond)?  $default,) {final _that = this;
switch (_that) {
case _EnergyState() when $default != null:
return $default(_that.currentEnergy,_that.energyPerSecond);case _:
  return null;

}
}

}

/// @nodoc


class _EnergyState implements EnergyState {
  const _EnergyState({required this.currentEnergy, required this.energyPerSecond});
  

@override final  BigNumber currentEnergy;
@override final  BigNumber energyPerSecond;

/// Create a copy of EnergyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnergyStateCopyWith<_EnergyState> get copyWith => __$EnergyStateCopyWithImpl<_EnergyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnergyState&&(identical(other.currentEnergy, currentEnergy) || other.currentEnergy == currentEnergy)&&(identical(other.energyPerSecond, energyPerSecond) || other.energyPerSecond == energyPerSecond));
}


@override
int get hashCode => Object.hash(runtimeType,currentEnergy,energyPerSecond);

@override
String toString() {
  return 'EnergyState(currentEnergy: $currentEnergy, energyPerSecond: $energyPerSecond)';
}


}

/// @nodoc
abstract mixin class _$EnergyStateCopyWith<$Res> implements $EnergyStateCopyWith<$Res> {
  factory _$EnergyStateCopyWith(_EnergyState value, $Res Function(_EnergyState) _then) = __$EnergyStateCopyWithImpl;
@override @useResult
$Res call({
 BigNumber currentEnergy, BigNumber energyPerSecond
});




}
/// @nodoc
class __$EnergyStateCopyWithImpl<$Res>
    implements _$EnergyStateCopyWith<$Res> {
  __$EnergyStateCopyWithImpl(this._self, this._then);

  final _EnergyState _self;
  final $Res Function(_EnergyState) _then;

/// Create a copy of EnergyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentEnergy = null,Object? energyPerSecond = null,}) {
  return _then(_EnergyState(
currentEnergy: null == currentEnergy ? _self.currentEnergy : currentEnergy // ignore: cast_nullable_to_non_nullable
as BigNumber,energyPerSecond: null == energyPerSecond ? _self.energyPerSecond : energyPerSecond // ignore: cast_nullable_to_non_nullable
as BigNumber,
  ));
}


}

// dart format on
