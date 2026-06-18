// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StorageEvent {

 StorageInventoryModel get model;
/// Create a copy of StorageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageEventCopyWith<StorageEvent> get copyWith => _$StorageEventCopyWithImpl<StorageEvent>(this as StorageEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageEvent&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,model);

@override
String toString() {
  return 'StorageEvent(model: $model)';
}


}

/// @nodoc
abstract mixin class $StorageEventCopyWith<$Res>  {
  factory $StorageEventCopyWith(StorageEvent value, $Res Function(StorageEvent) _then) = _$StorageEventCopyWithImpl;
@useResult
$Res call({
 StorageInventoryModel model
});


$StorageInventoryModelCopyWith<$Res> get model;

}
/// @nodoc
class _$StorageEventCopyWithImpl<$Res>
    implements $StorageEventCopyWith<$Res> {
  _$StorageEventCopyWithImpl(this._self, this._then);

  final StorageEvent _self;
  final $Res Function(StorageEvent) _then;

/// Create a copy of StorageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? model = null,}) {
  return _then(_self.copyWith(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as StorageInventoryModel,
  ));
}
/// Create a copy of StorageEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorageInventoryModelCopyWith<$Res> get model {
  
  return $StorageInventoryModelCopyWith<$Res>(_self.model, (value) {
    return _then(_self.copyWith(model: value));
  });
}
}


/// Adds pattern-matching-related methods to [StorageEvent].
extension StorageEventPatterns on StorageEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _InventoryChanged value)?  inventoryChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InventoryChanged() when inventoryChanged != null:
return inventoryChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _InventoryChanged value)  inventoryChanged,}){
final _that = this;
switch (_that) {
case _InventoryChanged():
return inventoryChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _InventoryChanged value)?  inventoryChanged,}){
final _that = this;
switch (_that) {
case _InventoryChanged() when inventoryChanged != null:
return inventoryChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( StorageInventoryModel model)?  inventoryChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InventoryChanged() when inventoryChanged != null:
return inventoryChanged(_that.model);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( StorageInventoryModel model)  inventoryChanged,}) {final _that = this;
switch (_that) {
case _InventoryChanged():
return inventoryChanged(_that.model);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( StorageInventoryModel model)?  inventoryChanged,}) {final _that = this;
switch (_that) {
case _InventoryChanged() when inventoryChanged != null:
return inventoryChanged(_that.model);case _:
  return null;

}
}

}

/// @nodoc


class _InventoryChanged implements StorageEvent {
  const _InventoryChanged(this.model);
  

@override final  StorageInventoryModel model;

/// Create a copy of StorageEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryChangedCopyWith<_InventoryChanged> get copyWith => __$InventoryChangedCopyWithImpl<_InventoryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryChanged&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,model);

@override
String toString() {
  return 'StorageEvent.inventoryChanged(model: $model)';
}


}

/// @nodoc
abstract mixin class _$InventoryChangedCopyWith<$Res> implements $StorageEventCopyWith<$Res> {
  factory _$InventoryChangedCopyWith(_InventoryChanged value, $Res Function(_InventoryChanged) _then) = __$InventoryChangedCopyWithImpl;
@override @useResult
$Res call({
 StorageInventoryModel model
});


@override $StorageInventoryModelCopyWith<$Res> get model;

}
/// @nodoc
class __$InventoryChangedCopyWithImpl<$Res>
    implements _$InventoryChangedCopyWith<$Res> {
  __$InventoryChangedCopyWithImpl(this._self, this._then);

  final _InventoryChanged _self;
  final $Res Function(_InventoryChanged) _then;

/// Create a copy of StorageEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? model = null,}) {
  return _then(_InventoryChanged(
null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as StorageInventoryModel,
  ));
}

/// Create a copy of StorageEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorageInventoryModelCopyWith<$Res> get model {
  
  return $StorageInventoryModelCopyWith<$Res>(_self.model, (value) {
    return _then(_self.copyWith(model: value));
  });
}
}

/// @nodoc
mixin _$StorageState {

 Map<ResearchMaterialId, int> get inventory; ResearchMaterialId? get lastAddedMaterial; int get lastAddedTimestamp;
/// Create a copy of StorageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageStateCopyWith<StorageState> get copyWith => _$StorageStateCopyWithImpl<StorageState>(this as StorageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageState&&const DeepCollectionEquality().equals(other.inventory, inventory)&&(identical(other.lastAddedMaterial, lastAddedMaterial) || other.lastAddedMaterial == lastAddedMaterial)&&(identical(other.lastAddedTimestamp, lastAddedTimestamp) || other.lastAddedTimestamp == lastAddedTimestamp));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(inventory),lastAddedMaterial,lastAddedTimestamp);

@override
String toString() {
  return 'StorageState(inventory: $inventory, lastAddedMaterial: $lastAddedMaterial, lastAddedTimestamp: $lastAddedTimestamp)';
}


}

/// @nodoc
abstract mixin class $StorageStateCopyWith<$Res>  {
  factory $StorageStateCopyWith(StorageState value, $Res Function(StorageState) _then) = _$StorageStateCopyWithImpl;
@useResult
$Res call({
 Map<ResearchMaterialId, int> inventory, ResearchMaterialId? lastAddedMaterial, int lastAddedTimestamp
});




}
/// @nodoc
class _$StorageStateCopyWithImpl<$Res>
    implements $StorageStateCopyWith<$Res> {
  _$StorageStateCopyWithImpl(this._self, this._then);

  final StorageState _self;
  final $Res Function(StorageState) _then;

/// Create a copy of StorageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inventory = null,Object? lastAddedMaterial = freezed,Object? lastAddedTimestamp = null,}) {
  return _then(_self.copyWith(
inventory: null == inventory ? _self.inventory : inventory // ignore: cast_nullable_to_non_nullable
as Map<ResearchMaterialId, int>,lastAddedMaterial: freezed == lastAddedMaterial ? _self.lastAddedMaterial : lastAddedMaterial // ignore: cast_nullable_to_non_nullable
as ResearchMaterialId?,lastAddedTimestamp: null == lastAddedTimestamp ? _self.lastAddedTimestamp : lastAddedTimestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StorageState].
extension StorageStatePatterns on StorageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorageState value)  $default,){
final _that = this;
switch (_that) {
case _StorageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorageState value)?  $default,){
final _that = this;
switch (_that) {
case _StorageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<ResearchMaterialId, int> inventory,  ResearchMaterialId? lastAddedMaterial,  int lastAddedTimestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorageState() when $default != null:
return $default(_that.inventory,_that.lastAddedMaterial,_that.lastAddedTimestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<ResearchMaterialId, int> inventory,  ResearchMaterialId? lastAddedMaterial,  int lastAddedTimestamp)  $default,) {final _that = this;
switch (_that) {
case _StorageState():
return $default(_that.inventory,_that.lastAddedMaterial,_that.lastAddedTimestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<ResearchMaterialId, int> inventory,  ResearchMaterialId? lastAddedMaterial,  int lastAddedTimestamp)?  $default,) {final _that = this;
switch (_that) {
case _StorageState() when $default != null:
return $default(_that.inventory,_that.lastAddedMaterial,_that.lastAddedTimestamp);case _:
  return null;

}
}

}

/// @nodoc


class _StorageState implements StorageState {
  const _StorageState({final  Map<ResearchMaterialId, int> inventory = const {}, this.lastAddedMaterial, this.lastAddedTimestamp = 0}): _inventory = inventory;
  

 final  Map<ResearchMaterialId, int> _inventory;
@override@JsonKey() Map<ResearchMaterialId, int> get inventory {
  if (_inventory is EqualUnmodifiableMapView) return _inventory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_inventory);
}

@override final  ResearchMaterialId? lastAddedMaterial;
@override@JsonKey() final  int lastAddedTimestamp;

/// Create a copy of StorageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorageStateCopyWith<_StorageState> get copyWith => __$StorageStateCopyWithImpl<_StorageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorageState&&const DeepCollectionEquality().equals(other._inventory, _inventory)&&(identical(other.lastAddedMaterial, lastAddedMaterial) || other.lastAddedMaterial == lastAddedMaterial)&&(identical(other.lastAddedTimestamp, lastAddedTimestamp) || other.lastAddedTimestamp == lastAddedTimestamp));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_inventory),lastAddedMaterial,lastAddedTimestamp);

@override
String toString() {
  return 'StorageState(inventory: $inventory, lastAddedMaterial: $lastAddedMaterial, lastAddedTimestamp: $lastAddedTimestamp)';
}


}

/// @nodoc
abstract mixin class _$StorageStateCopyWith<$Res> implements $StorageStateCopyWith<$Res> {
  factory _$StorageStateCopyWith(_StorageState value, $Res Function(_StorageState) _then) = __$StorageStateCopyWithImpl;
@override @useResult
$Res call({
 Map<ResearchMaterialId, int> inventory, ResearchMaterialId? lastAddedMaterial, int lastAddedTimestamp
});




}
/// @nodoc
class __$StorageStateCopyWithImpl<$Res>
    implements _$StorageStateCopyWith<$Res> {
  __$StorageStateCopyWithImpl(this._self, this._then);

  final _StorageState _self;
  final $Res Function(_StorageState) _then;

/// Create a copy of StorageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inventory = null,Object? lastAddedMaterial = freezed,Object? lastAddedTimestamp = null,}) {
  return _then(_StorageState(
inventory: null == inventory ? _self._inventory : inventory // ignore: cast_nullable_to_non_nullable
as Map<ResearchMaterialId, int>,lastAddedMaterial: freezed == lastAddedMaterial ? _self.lastAddedMaterial : lastAddedMaterial // ignore: cast_nullable_to_non_nullable
as ResearchMaterialId?,lastAddedTimestamp: null == lastAddedTimestamp ? _self.lastAddedTimestamp : lastAddedTimestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
