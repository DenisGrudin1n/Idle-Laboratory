// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_ending_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StoryEndingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryEndingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoryEndingEvent()';
}


}

/// @nodoc
class $StoryEndingEventCopyWith<$Res>  {
$StoryEndingEventCopyWith(StoryEndingEvent _, $Res Function(StoryEndingEvent) __);
}


/// Adds pattern-matching-related methods to [StoryEndingEvent].
extension StoryEndingEventPatterns on StoryEndingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _BloodstoneCrafted value)?  bloodstoneCrafted,TResult Function( _SequenceCompleted value)?  sequenceCompleted,TResult Function( _DebugReplay value)?  debugReplay,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BloodstoneCrafted() when bloodstoneCrafted != null:
return bloodstoneCrafted(_that);case _SequenceCompleted() when sequenceCompleted != null:
return sequenceCompleted(_that);case _DebugReplay() when debugReplay != null:
return debugReplay(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _BloodstoneCrafted value)  bloodstoneCrafted,required TResult Function( _SequenceCompleted value)  sequenceCompleted,required TResult Function( _DebugReplay value)  debugReplay,}){
final _that = this;
switch (_that) {
case _BloodstoneCrafted():
return bloodstoneCrafted(_that);case _SequenceCompleted():
return sequenceCompleted(_that);case _DebugReplay():
return debugReplay(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _BloodstoneCrafted value)?  bloodstoneCrafted,TResult? Function( _SequenceCompleted value)?  sequenceCompleted,TResult? Function( _DebugReplay value)?  debugReplay,}){
final _that = this;
switch (_that) {
case _BloodstoneCrafted() when bloodstoneCrafted != null:
return bloodstoneCrafted(_that);case _SequenceCompleted() when sequenceCompleted != null:
return sequenceCompleted(_that);case _DebugReplay() when debugReplay != null:
return debugReplay(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  bloodstoneCrafted,TResult Function()?  sequenceCompleted,TResult Function()?  debugReplay,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BloodstoneCrafted() when bloodstoneCrafted != null:
return bloodstoneCrafted();case _SequenceCompleted() when sequenceCompleted != null:
return sequenceCompleted();case _DebugReplay() when debugReplay != null:
return debugReplay();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  bloodstoneCrafted,required TResult Function()  sequenceCompleted,required TResult Function()  debugReplay,}) {final _that = this;
switch (_that) {
case _BloodstoneCrafted():
return bloodstoneCrafted();case _SequenceCompleted():
return sequenceCompleted();case _DebugReplay():
return debugReplay();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  bloodstoneCrafted,TResult? Function()?  sequenceCompleted,TResult? Function()?  debugReplay,}) {final _that = this;
switch (_that) {
case _BloodstoneCrafted() when bloodstoneCrafted != null:
return bloodstoneCrafted();case _SequenceCompleted() when sequenceCompleted != null:
return sequenceCompleted();case _DebugReplay() when debugReplay != null:
return debugReplay();case _:
  return null;

}
}

}

/// @nodoc


class _BloodstoneCrafted implements StoryEndingEvent {
  const _BloodstoneCrafted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BloodstoneCrafted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoryEndingEvent.bloodstoneCrafted()';
}


}




/// @nodoc


class _SequenceCompleted implements StoryEndingEvent {
  const _SequenceCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SequenceCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoryEndingEvent.sequenceCompleted()';
}


}




/// @nodoc


class _DebugReplay implements StoryEndingEvent {
  const _DebugReplay();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebugReplay);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoryEndingEvent.debugReplay()';
}


}




/// @nodoc
mixin _$StoryEndingState {

 bool get hasSeenEnding; bool get isPlaying; bool get pendingPlay;
/// Create a copy of StoryEndingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryEndingStateCopyWith<StoryEndingState> get copyWith => _$StoryEndingStateCopyWithImpl<StoryEndingState>(this as StoryEndingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryEndingState&&(identical(other.hasSeenEnding, hasSeenEnding) || other.hasSeenEnding == hasSeenEnding)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.pendingPlay, pendingPlay) || other.pendingPlay == pendingPlay));
}


@override
int get hashCode => Object.hash(runtimeType,hasSeenEnding,isPlaying,pendingPlay);

@override
String toString() {
  return 'StoryEndingState(hasSeenEnding: $hasSeenEnding, isPlaying: $isPlaying, pendingPlay: $pendingPlay)';
}


}

/// @nodoc
abstract mixin class $StoryEndingStateCopyWith<$Res>  {
  factory $StoryEndingStateCopyWith(StoryEndingState value, $Res Function(StoryEndingState) _then) = _$StoryEndingStateCopyWithImpl;
@useResult
$Res call({
 bool hasSeenEnding, bool isPlaying, bool pendingPlay
});




}
/// @nodoc
class _$StoryEndingStateCopyWithImpl<$Res>
    implements $StoryEndingStateCopyWith<$Res> {
  _$StoryEndingStateCopyWithImpl(this._self, this._then);

  final StoryEndingState _self;
  final $Res Function(StoryEndingState) _then;

/// Create a copy of StoryEndingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasSeenEnding = null,Object? isPlaying = null,Object? pendingPlay = null,}) {
  return _then(_self.copyWith(
hasSeenEnding: null == hasSeenEnding ? _self.hasSeenEnding : hasSeenEnding // ignore: cast_nullable_to_non_nullable
as bool,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,pendingPlay: null == pendingPlay ? _self.pendingPlay : pendingPlay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StoryEndingState].
extension StoryEndingStatePatterns on StoryEndingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoryEndingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoryEndingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoryEndingState value)  $default,){
final _that = this;
switch (_that) {
case _StoryEndingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoryEndingState value)?  $default,){
final _that = this;
switch (_that) {
case _StoryEndingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasSeenEnding,  bool isPlaying,  bool pendingPlay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoryEndingState() when $default != null:
return $default(_that.hasSeenEnding,_that.isPlaying,_that.pendingPlay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasSeenEnding,  bool isPlaying,  bool pendingPlay)  $default,) {final _that = this;
switch (_that) {
case _StoryEndingState():
return $default(_that.hasSeenEnding,_that.isPlaying,_that.pendingPlay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasSeenEnding,  bool isPlaying,  bool pendingPlay)?  $default,) {final _that = this;
switch (_that) {
case _StoryEndingState() when $default != null:
return $default(_that.hasSeenEnding,_that.isPlaying,_that.pendingPlay);case _:
  return null;

}
}

}

/// @nodoc


class _StoryEndingState implements StoryEndingState {
  const _StoryEndingState({required this.hasSeenEnding, this.isPlaying = false, this.pendingPlay = false});
  

@override final  bool hasSeenEnding;
@override@JsonKey() final  bool isPlaying;
@override@JsonKey() final  bool pendingPlay;

/// Create a copy of StoryEndingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryEndingStateCopyWith<_StoryEndingState> get copyWith => __$StoryEndingStateCopyWithImpl<_StoryEndingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoryEndingState&&(identical(other.hasSeenEnding, hasSeenEnding) || other.hasSeenEnding == hasSeenEnding)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.pendingPlay, pendingPlay) || other.pendingPlay == pendingPlay));
}


@override
int get hashCode => Object.hash(runtimeType,hasSeenEnding,isPlaying,pendingPlay);

@override
String toString() {
  return 'StoryEndingState(hasSeenEnding: $hasSeenEnding, isPlaying: $isPlaying, pendingPlay: $pendingPlay)';
}


}

/// @nodoc
abstract mixin class _$StoryEndingStateCopyWith<$Res> implements $StoryEndingStateCopyWith<$Res> {
  factory _$StoryEndingStateCopyWith(_StoryEndingState value, $Res Function(_StoryEndingState) _then) = __$StoryEndingStateCopyWithImpl;
@override @useResult
$Res call({
 bool hasSeenEnding, bool isPlaying, bool pendingPlay
});




}
/// @nodoc
class __$StoryEndingStateCopyWithImpl<$Res>
    implements _$StoryEndingStateCopyWith<$Res> {
  __$StoryEndingStateCopyWithImpl(this._self, this._then);

  final _StoryEndingState _self;
  final $Res Function(_StoryEndingState) _then;

/// Create a copy of StoryEndingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasSeenEnding = null,Object? isPlaying = null,Object? pendingPlay = null,}) {
  return _then(_StoryEndingState(
hasSeenEnding: null == hasSeenEnding ? _self.hasSeenEnding : hasSeenEnding // ignore: cast_nullable_to_non_nullable
as bool,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,pendingPlay: null == pendingPlay ? _self.pendingPlay : pendingPlay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
