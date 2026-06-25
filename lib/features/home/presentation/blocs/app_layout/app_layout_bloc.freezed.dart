// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_layout_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppLayoutEvent {

 AppVersionEnum get appVersion;
/// Create a copy of AppLayoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppLayoutEventCopyWith<AppLayoutEvent> get copyWith => _$AppLayoutEventCopyWithImpl<AppLayoutEvent>(this as AppLayoutEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppLayoutEvent&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}


@override
int get hashCode => Object.hash(runtimeType,appVersion);

@override
String toString() {
  return 'AppLayoutEvent(appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class $AppLayoutEventCopyWith<$Res>  {
  factory $AppLayoutEventCopyWith(AppLayoutEvent value, $Res Function(AppLayoutEvent) _then) = _$AppLayoutEventCopyWithImpl;
@useResult
$Res call({
 AppVersionEnum appVersion
});




}
/// @nodoc
class _$AppLayoutEventCopyWithImpl<$Res>
    implements $AppLayoutEventCopyWith<$Res> {
  _$AppLayoutEventCopyWithImpl(this._self, this._then);

  final AppLayoutEvent _self;
  final $Res Function(AppLayoutEvent) _then;

/// Create a copy of AppLayoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appVersion = null,}) {
  return _then(_self.copyWith(
appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as AppVersionEnum,
  ));
}

}


/// Adds pattern-matching-related methods to [AppLayoutEvent].
extension AppLayoutEventPatterns on AppLayoutEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _AppVersionChanged value)?  appVersionChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppVersionChanged() when appVersionChanged != null:
return appVersionChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _AppVersionChanged value)  appVersionChanged,}){
final _that = this;
switch (_that) {
case _AppVersionChanged():
return appVersionChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _AppVersionChanged value)?  appVersionChanged,}){
final _that = this;
switch (_that) {
case _AppVersionChanged() when appVersionChanged != null:
return appVersionChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AppVersionEnum appVersion)?  appVersionChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppVersionChanged() when appVersionChanged != null:
return appVersionChanged(_that.appVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AppVersionEnum appVersion)  appVersionChanged,}) {final _that = this;
switch (_that) {
case _AppVersionChanged():
return appVersionChanged(_that.appVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AppVersionEnum appVersion)?  appVersionChanged,}) {final _that = this;
switch (_that) {
case _AppVersionChanged() when appVersionChanged != null:
return appVersionChanged(_that.appVersion);case _:
  return null;

}
}

}

/// @nodoc


class _AppVersionChanged implements AppLayoutEvent {
  const _AppVersionChanged(this.appVersion);
  

@override final  AppVersionEnum appVersion;

/// Create a copy of AppLayoutEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppVersionChangedCopyWith<_AppVersionChanged> get copyWith => __$AppVersionChangedCopyWithImpl<_AppVersionChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppVersionChanged&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}


@override
int get hashCode => Object.hash(runtimeType,appVersion);

@override
String toString() {
  return 'AppLayoutEvent.appVersionChanged(appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class _$AppVersionChangedCopyWith<$Res> implements $AppLayoutEventCopyWith<$Res> {
  factory _$AppVersionChangedCopyWith(_AppVersionChanged value, $Res Function(_AppVersionChanged) _then) = __$AppVersionChangedCopyWithImpl;
@override @useResult
$Res call({
 AppVersionEnum appVersion
});




}
/// @nodoc
class __$AppVersionChangedCopyWithImpl<$Res>
    implements _$AppVersionChangedCopyWith<$Res> {
  __$AppVersionChangedCopyWithImpl(this._self, this._then);

  final _AppVersionChanged _self;
  final $Res Function(_AppVersionChanged) _then;

/// Create a copy of AppLayoutEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appVersion = null,}) {
  return _then(_AppVersionChanged(
null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as AppVersionEnum,
  ));
}


}

/// @nodoc
mixin _$AppLayoutState {

 AppVersionEnum get appVersion;
/// Create a copy of AppLayoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppLayoutStateCopyWith<AppLayoutState> get copyWith => _$AppLayoutStateCopyWithImpl<AppLayoutState>(this as AppLayoutState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppLayoutState&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}


@override
int get hashCode => Object.hash(runtimeType,appVersion);

@override
String toString() {
  return 'AppLayoutState(appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class $AppLayoutStateCopyWith<$Res>  {
  factory $AppLayoutStateCopyWith(AppLayoutState value, $Res Function(AppLayoutState) _then) = _$AppLayoutStateCopyWithImpl;
@useResult
$Res call({
 AppVersionEnum appVersion
});




}
/// @nodoc
class _$AppLayoutStateCopyWithImpl<$Res>
    implements $AppLayoutStateCopyWith<$Res> {
  _$AppLayoutStateCopyWithImpl(this._self, this._then);

  final AppLayoutState _self;
  final $Res Function(AppLayoutState) _then;

/// Create a copy of AppLayoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appVersion = null,}) {
  return _then(_self.copyWith(
appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as AppVersionEnum,
  ));
}

}


/// Adds pattern-matching-related methods to [AppLayoutState].
extension AppLayoutStatePatterns on AppLayoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AppVersionEnum appVersion)?  initial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.appVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AppVersionEnum appVersion)  initial,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.appVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AppVersionEnum appVersion)?  initial,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.appVersion);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AppLayoutState {
  const _Initial({required this.appVersion});
  

@override final  AppVersionEnum appVersion;

/// Create a copy of AppLayoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}


@override
int get hashCode => Object.hash(runtimeType,appVersion);

@override
String toString() {
  return 'AppLayoutState.initial(appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $AppLayoutStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 AppVersionEnum appVersion
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of AppLayoutState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appVersion = null,}) {
  return _then(_Initial(
appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as AppVersionEnum,
  ));
}


}

// dart format on
