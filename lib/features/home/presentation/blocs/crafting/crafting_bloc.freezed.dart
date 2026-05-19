// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crafting_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CraftingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CraftingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CraftingEvent()';
}


}

/// @nodoc
class $CraftingEventCopyWith<$Res>  {
$CraftingEventCopyWith(CraftingEvent _, $Res Function(CraftingEvent) __);
}


/// Adds pattern-matching-related methods to [CraftingEvent].
extension CraftingEventPatterns on CraftingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CellSlotChanged value)?  cellSlotChanged,TResult Function( _InputsCleared value)?  inputsCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CellSlotChanged() when cellSlotChanged != null:
return cellSlotChanged(_that);case _InputsCleared() when inputsCleared != null:
return inputsCleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CellSlotChanged value)  cellSlotChanged,required TResult Function( _InputsCleared value)  inputsCleared,}){
final _that = this;
switch (_that) {
case _CellSlotChanged():
return cellSlotChanged(_that);case _InputsCleared():
return inputsCleared(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CellSlotChanged value)?  cellSlotChanged,TResult? Function( _InputsCleared value)?  inputsCleared,}){
final _that = this;
switch (_that) {
case _CellSlotChanged() when cellSlotChanged != null:
return cellSlotChanged(_that);case _InputsCleared() when inputsCleared != null:
return inputsCleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( CellId? cellId)?  cellSlotChanged,TResult Function()?  inputsCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CellSlotChanged() when cellSlotChanged != null:
return cellSlotChanged(_that.cellId);case _InputsCleared() when inputsCleared != null:
return inputsCleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( CellId? cellId)  cellSlotChanged,required TResult Function()  inputsCleared,}) {final _that = this;
switch (_that) {
case _CellSlotChanged():
return cellSlotChanged(_that.cellId);case _InputsCleared():
return inputsCleared();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( CellId? cellId)?  cellSlotChanged,TResult? Function()?  inputsCleared,}) {final _that = this;
switch (_that) {
case _CellSlotChanged() when cellSlotChanged != null:
return cellSlotChanged(_that.cellId);case _InputsCleared() when inputsCleared != null:
return inputsCleared();case _:
  return null;

}
}

}

/// @nodoc


class _CellSlotChanged implements CraftingEvent {
  const _CellSlotChanged(this.cellId);
  

 final  CellId? cellId;

/// Create a copy of CraftingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CellSlotChangedCopyWith<_CellSlotChanged> get copyWith => __$CellSlotChangedCopyWithImpl<_CellSlotChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CellSlotChanged&&(identical(other.cellId, cellId) || other.cellId == cellId));
}


@override
int get hashCode => Object.hash(runtimeType,cellId);

@override
String toString() {
  return 'CraftingEvent.cellSlotChanged(cellId: $cellId)';
}


}

/// @nodoc
abstract mixin class _$CellSlotChangedCopyWith<$Res> implements $CraftingEventCopyWith<$Res> {
  factory _$CellSlotChangedCopyWith(_CellSlotChanged value, $Res Function(_CellSlotChanged) _then) = __$CellSlotChangedCopyWithImpl;
@useResult
$Res call({
 CellId? cellId
});




}
/// @nodoc
class __$CellSlotChangedCopyWithImpl<$Res>
    implements _$CellSlotChangedCopyWith<$Res> {
  __$CellSlotChangedCopyWithImpl(this._self, this._then);

  final _CellSlotChanged _self;
  final $Res Function(_CellSlotChanged) _then;

/// Create a copy of CraftingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cellId = freezed,}) {
  return _then(_CellSlotChanged(
freezed == cellId ? _self.cellId : cellId // ignore: cast_nullable_to_non_nullable
as CellId?,
  ));
}


}

/// @nodoc


class _InputsCleared implements CraftingEvent {
  const _InputsCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InputsCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CraftingEvent.inputsCleared()';
}


}




/// @nodoc
mixin _$CraftingState {

 CellId? get selectedCellId;
/// Create a copy of CraftingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CraftingStateCopyWith<CraftingState> get copyWith => _$CraftingStateCopyWithImpl<CraftingState>(this as CraftingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CraftingState&&(identical(other.selectedCellId, selectedCellId) || other.selectedCellId == selectedCellId));
}


@override
int get hashCode => Object.hash(runtimeType,selectedCellId);

@override
String toString() {
  return 'CraftingState(selectedCellId: $selectedCellId)';
}


}

/// @nodoc
abstract mixin class $CraftingStateCopyWith<$Res>  {
  factory $CraftingStateCopyWith(CraftingState value, $Res Function(CraftingState) _then) = _$CraftingStateCopyWithImpl;
@useResult
$Res call({
 CellId? selectedCellId
});




}
/// @nodoc
class _$CraftingStateCopyWithImpl<$Res>
    implements $CraftingStateCopyWith<$Res> {
  _$CraftingStateCopyWithImpl(this._self, this._then);

  final CraftingState _self;
  final $Res Function(CraftingState) _then;

/// Create a copy of CraftingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedCellId = freezed,}) {
  return _then(_self.copyWith(
selectedCellId: freezed == selectedCellId ? _self.selectedCellId : selectedCellId // ignore: cast_nullable_to_non_nullable
as CellId?,
  ));
}

}


/// Adds pattern-matching-related methods to [CraftingState].
extension CraftingStatePatterns on CraftingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CraftingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CraftingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CraftingState value)  $default,){
final _that = this;
switch (_that) {
case _CraftingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CraftingState value)?  $default,){
final _that = this;
switch (_that) {
case _CraftingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CellId? selectedCellId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CraftingState() when $default != null:
return $default(_that.selectedCellId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CellId? selectedCellId)  $default,) {final _that = this;
switch (_that) {
case _CraftingState():
return $default(_that.selectedCellId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CellId? selectedCellId)?  $default,) {final _that = this;
switch (_that) {
case _CraftingState() when $default != null:
return $default(_that.selectedCellId);case _:
  return null;

}
}

}

/// @nodoc


class _CraftingState implements CraftingState {
  const _CraftingState({this.selectedCellId});
  

@override final  CellId? selectedCellId;

/// Create a copy of CraftingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CraftingStateCopyWith<_CraftingState> get copyWith => __$CraftingStateCopyWithImpl<_CraftingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CraftingState&&(identical(other.selectedCellId, selectedCellId) || other.selectedCellId == selectedCellId));
}


@override
int get hashCode => Object.hash(runtimeType,selectedCellId);

@override
String toString() {
  return 'CraftingState(selectedCellId: $selectedCellId)';
}


}

/// @nodoc
abstract mixin class _$CraftingStateCopyWith<$Res> implements $CraftingStateCopyWith<$Res> {
  factory _$CraftingStateCopyWith(_CraftingState value, $Res Function(_CraftingState) _then) = __$CraftingStateCopyWithImpl;
@override @useResult
$Res call({
 CellId? selectedCellId
});




}
/// @nodoc
class __$CraftingStateCopyWithImpl<$Res>
    implements _$CraftingStateCopyWith<$Res> {
  __$CraftingStateCopyWithImpl(this._self, this._then);

  final _CraftingState _self;
  final $Res Function(_CraftingState) _then;

/// Create a copy of CraftingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedCellId = freezed,}) {
  return _then(_CraftingState(
selectedCellId: freezed == selectedCellId ? _self.selectedCellId : selectedCellId // ignore: cast_nullable_to_non_nullable
as CellId?,
  ));
}


}

// dart format on
