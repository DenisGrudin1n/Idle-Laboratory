// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cell_level_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CellLevelModel {

 int get level;@BigNumberConverter() BigNumber get energyRequired;
/// Create a copy of CellLevelModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CellLevelModelCopyWith<CellLevelModel> get copyWith => _$CellLevelModelCopyWithImpl<CellLevelModel>(this as CellLevelModel, _$identity);

  /// Serializes this CellLevelModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CellLevelModel&&(identical(other.level, level) || other.level == level)&&(identical(other.energyRequired, energyRequired) || other.energyRequired == energyRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,energyRequired);

@override
String toString() {
  return 'CellLevelModel(level: $level, energyRequired: $energyRequired)';
}


}

/// @nodoc
abstract mixin class $CellLevelModelCopyWith<$Res>  {
  factory $CellLevelModelCopyWith(CellLevelModel value, $Res Function(CellLevelModel) _then) = _$CellLevelModelCopyWithImpl;
@useResult
$Res call({
 int level,@BigNumberConverter() BigNumber energyRequired
});




}
/// @nodoc
class _$CellLevelModelCopyWithImpl<$Res>
    implements $CellLevelModelCopyWith<$Res> {
  _$CellLevelModelCopyWithImpl(this._self, this._then);

  final CellLevelModel _self;
  final $Res Function(CellLevelModel) _then;

/// Create a copy of CellLevelModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? energyRequired = null,}) {
  return _then(_self.copyWith(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,energyRequired: null == energyRequired ? _self.energyRequired : energyRequired // ignore: cast_nullable_to_non_nullable
as BigNumber,
  ));
}

}


/// Adds pattern-matching-related methods to [CellLevelModel].
extension CellLevelModelPatterns on CellLevelModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CellLevelModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CellLevelModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CellLevelModel value)  $default,){
final _that = this;
switch (_that) {
case _CellLevelModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CellLevelModel value)?  $default,){
final _that = this;
switch (_that) {
case _CellLevelModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int level, @BigNumberConverter()  BigNumber energyRequired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CellLevelModel() when $default != null:
return $default(_that.level,_that.energyRequired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int level, @BigNumberConverter()  BigNumber energyRequired)  $default,) {final _that = this;
switch (_that) {
case _CellLevelModel():
return $default(_that.level,_that.energyRequired);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int level, @BigNumberConverter()  BigNumber energyRequired)?  $default,) {final _that = this;
switch (_that) {
case _CellLevelModel() when $default != null:
return $default(_that.level,_that.energyRequired);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CellLevelModel implements CellLevelModel {
  const _CellLevelModel({required this.level, @BigNumberConverter() required this.energyRequired});
  factory _CellLevelModel.fromJson(Map<String, dynamic> json) => _$CellLevelModelFromJson(json);

@override final  int level;
@override@BigNumberConverter() final  BigNumber energyRequired;

/// Create a copy of CellLevelModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CellLevelModelCopyWith<_CellLevelModel> get copyWith => __$CellLevelModelCopyWithImpl<_CellLevelModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CellLevelModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CellLevelModel&&(identical(other.level, level) || other.level == level)&&(identical(other.energyRequired, energyRequired) || other.energyRequired == energyRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,energyRequired);

@override
String toString() {
  return 'CellLevelModel(level: $level, energyRequired: $energyRequired)';
}


}

/// @nodoc
abstract mixin class _$CellLevelModelCopyWith<$Res> implements $CellLevelModelCopyWith<$Res> {
  factory _$CellLevelModelCopyWith(_CellLevelModel value, $Res Function(_CellLevelModel) _then) = __$CellLevelModelCopyWithImpl;
@override @useResult
$Res call({
 int level,@BigNumberConverter() BigNumber energyRequired
});




}
/// @nodoc
class __$CellLevelModelCopyWithImpl<$Res>
    implements _$CellLevelModelCopyWith<$Res> {
  __$CellLevelModelCopyWithImpl(this._self, this._then);

  final _CellLevelModel _self;
  final $Res Function(_CellLevelModel) _then;

/// Create a copy of CellLevelModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? energyRequired = null,}) {
  return _then(_CellLevelModel(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,energyRequired: null == energyRequired ? _self.energyRequired : energyRequired // ignore: cast_nullable_to_non_nullable
as BigNumber,
  ));
}


}

// dart format on
