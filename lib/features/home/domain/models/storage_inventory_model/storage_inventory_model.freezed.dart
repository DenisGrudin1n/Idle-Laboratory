// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_inventory_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StorageInventoryModel {

 Map<ResearchMaterialId, int> get inventory;
/// Create a copy of StorageInventoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageInventoryModelCopyWith<StorageInventoryModel> get copyWith => _$StorageInventoryModelCopyWithImpl<StorageInventoryModel>(this as StorageInventoryModel, _$identity);

  /// Serializes this StorageInventoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageInventoryModel&&const DeepCollectionEquality().equals(other.inventory, inventory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(inventory));

@override
String toString() {
  return 'StorageInventoryModel(inventory: $inventory)';
}


}

/// @nodoc
abstract mixin class $StorageInventoryModelCopyWith<$Res>  {
  factory $StorageInventoryModelCopyWith(StorageInventoryModel value, $Res Function(StorageInventoryModel) _then) = _$StorageInventoryModelCopyWithImpl;
@useResult
$Res call({
 Map<ResearchMaterialId, int> inventory
});




}
/// @nodoc
class _$StorageInventoryModelCopyWithImpl<$Res>
    implements $StorageInventoryModelCopyWith<$Res> {
  _$StorageInventoryModelCopyWithImpl(this._self, this._then);

  final StorageInventoryModel _self;
  final $Res Function(StorageInventoryModel) _then;

/// Create a copy of StorageInventoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inventory = null,}) {
  return _then(_self.copyWith(
inventory: null == inventory ? _self.inventory : inventory // ignore: cast_nullable_to_non_nullable
as Map<ResearchMaterialId, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [StorageInventoryModel].
extension StorageInventoryModelPatterns on StorageInventoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorageInventoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorageInventoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorageInventoryModel value)  $default,){
final _that = this;
switch (_that) {
case _StorageInventoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorageInventoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _StorageInventoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<ResearchMaterialId, int> inventory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorageInventoryModel() when $default != null:
return $default(_that.inventory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<ResearchMaterialId, int> inventory)  $default,) {final _that = this;
switch (_that) {
case _StorageInventoryModel():
return $default(_that.inventory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<ResearchMaterialId, int> inventory)?  $default,) {final _that = this;
switch (_that) {
case _StorageInventoryModel() when $default != null:
return $default(_that.inventory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorageInventoryModel implements StorageInventoryModel {
  const _StorageInventoryModel({final  Map<ResearchMaterialId, int> inventory = const {}}): _inventory = inventory;
  factory _StorageInventoryModel.fromJson(Map<String, dynamic> json) => _$StorageInventoryModelFromJson(json);

 final  Map<ResearchMaterialId, int> _inventory;
@override@JsonKey() Map<ResearchMaterialId, int> get inventory {
  if (_inventory is EqualUnmodifiableMapView) return _inventory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_inventory);
}


/// Create a copy of StorageInventoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorageInventoryModelCopyWith<_StorageInventoryModel> get copyWith => __$StorageInventoryModelCopyWithImpl<_StorageInventoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorageInventoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorageInventoryModel&&const DeepCollectionEquality().equals(other._inventory, _inventory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_inventory));

@override
String toString() {
  return 'StorageInventoryModel(inventory: $inventory)';
}


}

/// @nodoc
abstract mixin class _$StorageInventoryModelCopyWith<$Res> implements $StorageInventoryModelCopyWith<$Res> {
  factory _$StorageInventoryModelCopyWith(_StorageInventoryModel value, $Res Function(_StorageInventoryModel) _then) = __$StorageInventoryModelCopyWithImpl;
@override @useResult
$Res call({
 Map<ResearchMaterialId, int> inventory
});




}
/// @nodoc
class __$StorageInventoryModelCopyWithImpl<$Res>
    implements _$StorageInventoryModelCopyWith<$Res> {
  __$StorageInventoryModelCopyWithImpl(this._self, this._then);

  final _StorageInventoryModel _self;
  final $Res Function(_StorageInventoryModel) _then;

/// Create a copy of StorageInventoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inventory = null,}) {
  return _then(_StorageInventoryModel(
inventory: null == inventory ? _self._inventory : inventory // ignore: cast_nullable_to_non_nullable
as Map<ResearchMaterialId, int>,
  ));
}


}

// dart format on
