// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cell_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CellModel {

 String get id; CellName get name; CellType get type; int get level; bool get isLocked; int? get requiredLevel; String? get energyPerSecond;
/// Create a copy of CellModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CellModelCopyWith<CellModel> get copyWith => _$CellModelCopyWithImpl<CellModel>(this as CellModel, _$identity);

  /// Serializes this CellModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CellModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.level, level) || other.level == level)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.requiredLevel, requiredLevel) || other.requiredLevel == requiredLevel)&&(identical(other.energyPerSecond, energyPerSecond) || other.energyPerSecond == energyPerSecond));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,level,isLocked,requiredLevel,energyPerSecond);

@override
String toString() {
  return 'CellModel(id: $id, name: $name, type: $type, level: $level, isLocked: $isLocked, requiredLevel: $requiredLevel, energyPerSecond: $energyPerSecond)';
}


}

/// @nodoc
abstract mixin class $CellModelCopyWith<$Res>  {
  factory $CellModelCopyWith(CellModel value, $Res Function(CellModel) _then) = _$CellModelCopyWithImpl;
@useResult
$Res call({
 String id, CellName name, CellType type, int level, bool isLocked, int? requiredLevel, String? energyPerSecond
});




}
/// @nodoc
class _$CellModelCopyWithImpl<$Res>
    implements $CellModelCopyWith<$Res> {
  _$CellModelCopyWithImpl(this._self, this._then);

  final CellModel _self;
  final $Res Function(CellModel) _then;

/// Create a copy of CellModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? level = null,Object? isLocked = null,Object? requiredLevel = freezed,Object? energyPerSecond = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as CellName,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CellType,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,requiredLevel: freezed == requiredLevel ? _self.requiredLevel : requiredLevel // ignore: cast_nullable_to_non_nullable
as int?,energyPerSecond: freezed == energyPerSecond ? _self.energyPerSecond : energyPerSecond // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CellModel].
extension CellModelPatterns on CellModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CellModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CellModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CellModel value)  $default,){
final _that = this;
switch (_that) {
case _CellModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CellModel value)?  $default,){
final _that = this;
switch (_that) {
case _CellModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  CellName name,  CellType type,  int level,  bool isLocked,  int? requiredLevel,  String? energyPerSecond)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CellModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.level,_that.isLocked,_that.requiredLevel,_that.energyPerSecond);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  CellName name,  CellType type,  int level,  bool isLocked,  int? requiredLevel,  String? energyPerSecond)  $default,) {final _that = this;
switch (_that) {
case _CellModel():
return $default(_that.id,_that.name,_that.type,_that.level,_that.isLocked,_that.requiredLevel,_that.energyPerSecond);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  CellName name,  CellType type,  int level,  bool isLocked,  int? requiredLevel,  String? energyPerSecond)?  $default,) {final _that = this;
switch (_that) {
case _CellModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.level,_that.isLocked,_that.requiredLevel,_that.energyPerSecond);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CellModel implements CellModel {
  const _CellModel({required this.id, required this.name, required this.type, required this.level, required this.isLocked, this.requiredLevel, this.energyPerSecond});
  factory _CellModel.fromJson(Map<String, dynamic> json) => _$CellModelFromJson(json);

@override final  String id;
@override final  CellName name;
@override final  CellType type;
@override final  int level;
@override final  bool isLocked;
@override final  int? requiredLevel;
@override final  String? energyPerSecond;

/// Create a copy of CellModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CellModelCopyWith<_CellModel> get copyWith => __$CellModelCopyWithImpl<_CellModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CellModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CellModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.level, level) || other.level == level)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.requiredLevel, requiredLevel) || other.requiredLevel == requiredLevel)&&(identical(other.energyPerSecond, energyPerSecond) || other.energyPerSecond == energyPerSecond));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,level,isLocked,requiredLevel,energyPerSecond);

@override
String toString() {
  return 'CellModel(id: $id, name: $name, type: $type, level: $level, isLocked: $isLocked, requiredLevel: $requiredLevel, energyPerSecond: $energyPerSecond)';
}


}

/// @nodoc
abstract mixin class _$CellModelCopyWith<$Res> implements $CellModelCopyWith<$Res> {
  factory _$CellModelCopyWith(_CellModel value, $Res Function(_CellModel) _then) = __$CellModelCopyWithImpl;
@override @useResult
$Res call({
 String id, CellName name, CellType type, int level, bool isLocked, int? requiredLevel, String? energyPerSecond
});




}
/// @nodoc
class __$CellModelCopyWithImpl<$Res>
    implements _$CellModelCopyWith<$Res> {
  __$CellModelCopyWithImpl(this._self, this._then);

  final _CellModel _self;
  final $Res Function(_CellModel) _then;

/// Create a copy of CellModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? level = null,Object? isLocked = null,Object? requiredLevel = freezed,Object? energyPerSecond = freezed,}) {
  return _then(_CellModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as CellName,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CellType,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,requiredLevel: freezed == requiredLevel ? _self.requiredLevel : requiredLevel // ignore: cast_nullable_to_non_nullable
as int?,energyPerSecond: freezed == energyPerSecond ? _self.energyPerSecond : energyPerSecond // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
