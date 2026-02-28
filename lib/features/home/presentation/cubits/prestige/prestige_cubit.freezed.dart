// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prestige_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrestigeState {

 PrestigeStateModel? get prestigeState;
/// Create a copy of PrestigeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrestigeStateCopyWith<PrestigeState> get copyWith => _$PrestigeStateCopyWithImpl<PrestigeState>(this as PrestigeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrestigeState&&(identical(other.prestigeState, prestigeState) || other.prestigeState == prestigeState));
}


@override
int get hashCode => Object.hash(runtimeType,prestigeState);

@override
String toString() {
  return 'PrestigeState(prestigeState: $prestigeState)';
}


}

/// @nodoc
abstract mixin class $PrestigeStateCopyWith<$Res>  {
  factory $PrestigeStateCopyWith(PrestigeState value, $Res Function(PrestigeState) _then) = _$PrestigeStateCopyWithImpl;
@useResult
$Res call({
 PrestigeStateModel? prestigeState
});


$PrestigeStateModelCopyWith<$Res>? get prestigeState;

}
/// @nodoc
class _$PrestigeStateCopyWithImpl<$Res>
    implements $PrestigeStateCopyWith<$Res> {
  _$PrestigeStateCopyWithImpl(this._self, this._then);

  final PrestigeState _self;
  final $Res Function(PrestigeState) _then;

/// Create a copy of PrestigeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prestigeState = freezed,}) {
  return _then(_self.copyWith(
prestigeState: freezed == prestigeState ? _self.prestigeState : prestigeState // ignore: cast_nullable_to_non_nullable
as PrestigeStateModel?,
  ));
}
/// Create a copy of PrestigeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrestigeStateModelCopyWith<$Res>? get prestigeState {
    if (_self.prestigeState == null) {
    return null;
  }

  return $PrestigeStateModelCopyWith<$Res>(_self.prestigeState!, (value) {
    return _then(_self.copyWith(prestigeState: value));
  });
}
}


/// Adds pattern-matching-related methods to [PrestigeState].
extension PrestigeStatePatterns on PrestigeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrestigeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrestigeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrestigeState value)  $default,){
final _that = this;
switch (_that) {
case _PrestigeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrestigeState value)?  $default,){
final _that = this;
switch (_that) {
case _PrestigeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PrestigeStateModel? prestigeState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrestigeState() when $default != null:
return $default(_that.prestigeState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PrestigeStateModel? prestigeState)  $default,) {final _that = this;
switch (_that) {
case _PrestigeState():
return $default(_that.prestigeState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PrestigeStateModel? prestigeState)?  $default,) {final _that = this;
switch (_that) {
case _PrestigeState() when $default != null:
return $default(_that.prestigeState);case _:
  return null;

}
}

}

/// @nodoc


class _PrestigeState implements PrestigeState {
  const _PrestigeState({this.prestigeState});
  

@override final  PrestigeStateModel? prestigeState;

/// Create a copy of PrestigeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrestigeStateCopyWith<_PrestigeState> get copyWith => __$PrestigeStateCopyWithImpl<_PrestigeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrestigeState&&(identical(other.prestigeState, prestigeState) || other.prestigeState == prestigeState));
}


@override
int get hashCode => Object.hash(runtimeType,prestigeState);

@override
String toString() {
  return 'PrestigeState(prestigeState: $prestigeState)';
}


}

/// @nodoc
abstract mixin class _$PrestigeStateCopyWith<$Res> implements $PrestigeStateCopyWith<$Res> {
  factory _$PrestigeStateCopyWith(_PrestigeState value, $Res Function(_PrestigeState) _then) = __$PrestigeStateCopyWithImpl;
@override @useResult
$Res call({
 PrestigeStateModel? prestigeState
});


@override $PrestigeStateModelCopyWith<$Res>? get prestigeState;

}
/// @nodoc
class __$PrestigeStateCopyWithImpl<$Res>
    implements _$PrestigeStateCopyWith<$Res> {
  __$PrestigeStateCopyWithImpl(this._self, this._then);

  final _PrestigeState _self;
  final $Res Function(_PrestigeState) _then;

/// Create a copy of PrestigeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? prestigeState = freezed,}) {
  return _then(_PrestigeState(
prestigeState: freezed == prestigeState ? _self.prestigeState : prestigeState // ignore: cast_nullable_to_non_nullable
as PrestigeStateModel?,
  ));
}

/// Create a copy of PrestigeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrestigeStateModelCopyWith<$Res>? get prestigeState {
    if (_self.prestigeState == null) {
    return null;
  }

  return $PrestigeStateModelCopyWith<$Res>(_self.prestigeState!, (value) {
    return _then(_self.copyWith(prestigeState: value));
  });
}
}

// dart format on
