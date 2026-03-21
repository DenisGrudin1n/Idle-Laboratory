// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'energy_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EnergyEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnergyEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EnergyEvent()';
}


}

/// @nodoc
class $EnergyEventCopyWith<$Res>  {
$EnergyEventCopyWith(EnergyEvent _, $Res Function(EnergyEvent) __);
}


/// Adds pattern-matching-related methods to [EnergyEvent].
extension EnergyEventPatterns on EnergyEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _EnergyChanged value)?  energyChanged,TResult Function( _EpsChanged value)?  epsChanged,TResult Function( _Start value)?  start,TResult Function( _UpdateEPS value)?  updateEPS,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnergyChanged() when energyChanged != null:
return energyChanged(_that);case _EpsChanged() when epsChanged != null:
return epsChanged(_that);case _Start() when start != null:
return start(_that);case _UpdateEPS() when updateEPS != null:
return updateEPS(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _EnergyChanged value)  energyChanged,required TResult Function( _EpsChanged value)  epsChanged,required TResult Function( _Start value)  start,required TResult Function( _UpdateEPS value)  updateEPS,}){
final _that = this;
switch (_that) {
case _EnergyChanged():
return energyChanged(_that);case _EpsChanged():
return epsChanged(_that);case _Start():
return start(_that);case _UpdateEPS():
return updateEPS(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _EnergyChanged value)?  energyChanged,TResult? Function( _EpsChanged value)?  epsChanged,TResult? Function( _Start value)?  start,TResult? Function( _UpdateEPS value)?  updateEPS,}){
final _that = this;
switch (_that) {
case _EnergyChanged() when energyChanged != null:
return energyChanged(_that);case _EpsChanged() when epsChanged != null:
return epsChanged(_that);case _Start() when start != null:
return start(_that);case _UpdateEPS() when updateEPS != null:
return updateEPS(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( BigNumber energy)?  energyChanged,TResult Function( BigNumber eps)?  epsChanged,TResult Function()?  start,TResult Function( BigNumber eps)?  updateEPS,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnergyChanged() when energyChanged != null:
return energyChanged(_that.energy);case _EpsChanged() when epsChanged != null:
return epsChanged(_that.eps);case _Start() when start != null:
return start();case _UpdateEPS() when updateEPS != null:
return updateEPS(_that.eps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( BigNumber energy)  energyChanged,required TResult Function( BigNumber eps)  epsChanged,required TResult Function()  start,required TResult Function( BigNumber eps)  updateEPS,}) {final _that = this;
switch (_that) {
case _EnergyChanged():
return energyChanged(_that.energy);case _EpsChanged():
return epsChanged(_that.eps);case _Start():
return start();case _UpdateEPS():
return updateEPS(_that.eps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( BigNumber energy)?  energyChanged,TResult? Function( BigNumber eps)?  epsChanged,TResult? Function()?  start,TResult? Function( BigNumber eps)?  updateEPS,}) {final _that = this;
switch (_that) {
case _EnergyChanged() when energyChanged != null:
return energyChanged(_that.energy);case _EpsChanged() when epsChanged != null:
return epsChanged(_that.eps);case _Start() when start != null:
return start();case _UpdateEPS() when updateEPS != null:
return updateEPS(_that.eps);case _:
  return null;

}
}

}

/// @nodoc


class _EnergyChanged implements EnergyEvent {
  const _EnergyChanged(this.energy);
  

 final  BigNumber energy;

/// Create a copy of EnergyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnergyChangedCopyWith<_EnergyChanged> get copyWith => __$EnergyChangedCopyWithImpl<_EnergyChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnergyChanged&&(identical(other.energy, energy) || other.energy == energy));
}


@override
int get hashCode => Object.hash(runtimeType,energy);

@override
String toString() {
  return 'EnergyEvent.energyChanged(energy: $energy)';
}


}

/// @nodoc
abstract mixin class _$EnergyChangedCopyWith<$Res> implements $EnergyEventCopyWith<$Res> {
  factory _$EnergyChangedCopyWith(_EnergyChanged value, $Res Function(_EnergyChanged) _then) = __$EnergyChangedCopyWithImpl;
@useResult
$Res call({
 BigNumber energy
});




}
/// @nodoc
class __$EnergyChangedCopyWithImpl<$Res>
    implements _$EnergyChangedCopyWith<$Res> {
  __$EnergyChangedCopyWithImpl(this._self, this._then);

  final _EnergyChanged _self;
  final $Res Function(_EnergyChanged) _then;

/// Create a copy of EnergyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? energy = null,}) {
  return _then(_EnergyChanged(
null == energy ? _self.energy : energy // ignore: cast_nullable_to_non_nullable
as BigNumber,
  ));
}


}

/// @nodoc


class _EpsChanged implements EnergyEvent {
  const _EpsChanged(this.eps);
  

 final  BigNumber eps;

/// Create a copy of EnergyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpsChangedCopyWith<_EpsChanged> get copyWith => __$EpsChangedCopyWithImpl<_EpsChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EpsChanged&&(identical(other.eps, eps) || other.eps == eps));
}


@override
int get hashCode => Object.hash(runtimeType,eps);

@override
String toString() {
  return 'EnergyEvent.epsChanged(eps: $eps)';
}


}

/// @nodoc
abstract mixin class _$EpsChangedCopyWith<$Res> implements $EnergyEventCopyWith<$Res> {
  factory _$EpsChangedCopyWith(_EpsChanged value, $Res Function(_EpsChanged) _then) = __$EpsChangedCopyWithImpl;
@useResult
$Res call({
 BigNumber eps
});




}
/// @nodoc
class __$EpsChangedCopyWithImpl<$Res>
    implements _$EpsChangedCopyWith<$Res> {
  __$EpsChangedCopyWithImpl(this._self, this._then);

  final _EpsChanged _self;
  final $Res Function(_EpsChanged) _then;

/// Create a copy of EnergyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? eps = null,}) {
  return _then(_EpsChanged(
null == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as BigNumber,
  ));
}


}

/// @nodoc


class _Start implements EnergyEvent {
  const _Start();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Start);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EnergyEvent.start()';
}


}




/// @nodoc


class _UpdateEPS implements EnergyEvent {
  const _UpdateEPS(this.eps);
  

 final  BigNumber eps;

/// Create a copy of EnergyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateEPSCopyWith<_UpdateEPS> get copyWith => __$UpdateEPSCopyWithImpl<_UpdateEPS>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateEPS&&(identical(other.eps, eps) || other.eps == eps));
}


@override
int get hashCode => Object.hash(runtimeType,eps);

@override
String toString() {
  return 'EnergyEvent.updateEPS(eps: $eps)';
}


}

/// @nodoc
abstract mixin class _$UpdateEPSCopyWith<$Res> implements $EnergyEventCopyWith<$Res> {
  factory _$UpdateEPSCopyWith(_UpdateEPS value, $Res Function(_UpdateEPS) _then) = __$UpdateEPSCopyWithImpl;
@useResult
$Res call({
 BigNumber eps
});




}
/// @nodoc
class __$UpdateEPSCopyWithImpl<$Res>
    implements _$UpdateEPSCopyWith<$Res> {
  __$UpdateEPSCopyWithImpl(this._self, this._then);

  final _UpdateEPS _self;
  final $Res Function(_UpdateEPS) _then;

/// Create a copy of EnergyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? eps = null,}) {
  return _then(_UpdateEPS(
null == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as BigNumber,
  ));
}


}

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
