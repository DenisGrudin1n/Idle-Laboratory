// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prestige_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrestigeStateModel {

@BigNumberConverter() BigNumber get totalMultiplier;@BigNumberConverter() BigNumber get currentThreshold;@BigNumberConverter() BigNumber get currentMultiplier; bool get isUnlocked; int get prestigeCount;
/// Create a copy of PrestigeStateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrestigeStateModelCopyWith<PrestigeStateModel> get copyWith => _$PrestigeStateModelCopyWithImpl<PrestigeStateModel>(this as PrestigeStateModel, _$identity);

  /// Serializes this PrestigeStateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrestigeStateModel&&(identical(other.totalMultiplier, totalMultiplier) || other.totalMultiplier == totalMultiplier)&&(identical(other.currentThreshold, currentThreshold) || other.currentThreshold == currentThreshold)&&(identical(other.currentMultiplier, currentMultiplier) || other.currentMultiplier == currentMultiplier)&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked)&&(identical(other.prestigeCount, prestigeCount) || other.prestigeCount == prestigeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalMultiplier,currentThreshold,currentMultiplier,isUnlocked,prestigeCount);

@override
String toString() {
  return 'PrestigeStateModel(totalMultiplier: $totalMultiplier, currentThreshold: $currentThreshold, currentMultiplier: $currentMultiplier, isUnlocked: $isUnlocked, prestigeCount: $prestigeCount)';
}


}

/// @nodoc
abstract mixin class $PrestigeStateModelCopyWith<$Res>  {
  factory $PrestigeStateModelCopyWith(PrestigeStateModel value, $Res Function(PrestigeStateModel) _then) = _$PrestigeStateModelCopyWithImpl;
@useResult
$Res call({
@BigNumberConverter() BigNumber totalMultiplier,@BigNumberConverter() BigNumber currentThreshold,@BigNumberConverter() BigNumber currentMultiplier, bool isUnlocked, int prestigeCount
});




}
/// @nodoc
class _$PrestigeStateModelCopyWithImpl<$Res>
    implements $PrestigeStateModelCopyWith<$Res> {
  _$PrestigeStateModelCopyWithImpl(this._self, this._then);

  final PrestigeStateModel _self;
  final $Res Function(PrestigeStateModel) _then;

/// Create a copy of PrestigeStateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalMultiplier = null,Object? currentThreshold = null,Object? currentMultiplier = null,Object? isUnlocked = null,Object? prestigeCount = null,}) {
  return _then(_self.copyWith(
totalMultiplier: null == totalMultiplier ? _self.totalMultiplier : totalMultiplier // ignore: cast_nullable_to_non_nullable
as BigNumber,currentThreshold: null == currentThreshold ? _self.currentThreshold : currentThreshold // ignore: cast_nullable_to_non_nullable
as BigNumber,currentMultiplier: null == currentMultiplier ? _self.currentMultiplier : currentMultiplier // ignore: cast_nullable_to_non_nullable
as BigNumber,isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,prestigeCount: null == prestigeCount ? _self.prestigeCount : prestigeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PrestigeStateModel].
extension PrestigeStateModelPatterns on PrestigeStateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrestigeStateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrestigeStateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrestigeStateModel value)  $default,){
final _that = this;
switch (_that) {
case _PrestigeStateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrestigeStateModel value)?  $default,){
final _that = this;
switch (_that) {
case _PrestigeStateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@BigNumberConverter()  BigNumber totalMultiplier, @BigNumberConverter()  BigNumber currentThreshold, @BigNumberConverter()  BigNumber currentMultiplier,  bool isUnlocked,  int prestigeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrestigeStateModel() when $default != null:
return $default(_that.totalMultiplier,_that.currentThreshold,_that.currentMultiplier,_that.isUnlocked,_that.prestigeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@BigNumberConverter()  BigNumber totalMultiplier, @BigNumberConverter()  BigNumber currentThreshold, @BigNumberConverter()  BigNumber currentMultiplier,  bool isUnlocked,  int prestigeCount)  $default,) {final _that = this;
switch (_that) {
case _PrestigeStateModel():
return $default(_that.totalMultiplier,_that.currentThreshold,_that.currentMultiplier,_that.isUnlocked,_that.prestigeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@BigNumberConverter()  BigNumber totalMultiplier, @BigNumberConverter()  BigNumber currentThreshold, @BigNumberConverter()  BigNumber currentMultiplier,  bool isUnlocked,  int prestigeCount)?  $default,) {final _that = this;
switch (_that) {
case _PrestigeStateModel() when $default != null:
return $default(_that.totalMultiplier,_that.currentThreshold,_that.currentMultiplier,_that.isUnlocked,_that.prestigeCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrestigeStateModel implements PrestigeStateModel {
  const _PrestigeStateModel({@BigNumberConverter() required this.totalMultiplier, @BigNumberConverter() required this.currentThreshold, @BigNumberConverter() required this.currentMultiplier, required this.isUnlocked, required this.prestigeCount});
  factory _PrestigeStateModel.fromJson(Map<String, dynamic> json) => _$PrestigeStateModelFromJson(json);

@override@BigNumberConverter() final  BigNumber totalMultiplier;
@override@BigNumberConverter() final  BigNumber currentThreshold;
@override@BigNumberConverter() final  BigNumber currentMultiplier;
@override final  bool isUnlocked;
@override final  int prestigeCount;

/// Create a copy of PrestigeStateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrestigeStateModelCopyWith<_PrestigeStateModel> get copyWith => __$PrestigeStateModelCopyWithImpl<_PrestigeStateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrestigeStateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrestigeStateModel&&(identical(other.totalMultiplier, totalMultiplier) || other.totalMultiplier == totalMultiplier)&&(identical(other.currentThreshold, currentThreshold) || other.currentThreshold == currentThreshold)&&(identical(other.currentMultiplier, currentMultiplier) || other.currentMultiplier == currentMultiplier)&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked)&&(identical(other.prestigeCount, prestigeCount) || other.prestigeCount == prestigeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalMultiplier,currentThreshold,currentMultiplier,isUnlocked,prestigeCount);

@override
String toString() {
  return 'PrestigeStateModel(totalMultiplier: $totalMultiplier, currentThreshold: $currentThreshold, currentMultiplier: $currentMultiplier, isUnlocked: $isUnlocked, prestigeCount: $prestigeCount)';
}


}

/// @nodoc
abstract mixin class _$PrestigeStateModelCopyWith<$Res> implements $PrestigeStateModelCopyWith<$Res> {
  factory _$PrestigeStateModelCopyWith(_PrestigeStateModel value, $Res Function(_PrestigeStateModel) _then) = __$PrestigeStateModelCopyWithImpl;
@override @useResult
$Res call({
@BigNumberConverter() BigNumber totalMultiplier,@BigNumberConverter() BigNumber currentThreshold,@BigNumberConverter() BigNumber currentMultiplier, bool isUnlocked, int prestigeCount
});




}
/// @nodoc
class __$PrestigeStateModelCopyWithImpl<$Res>
    implements _$PrestigeStateModelCopyWith<$Res> {
  __$PrestigeStateModelCopyWithImpl(this._self, this._then);

  final _PrestigeStateModel _self;
  final $Res Function(_PrestigeStateModel) _then;

/// Create a copy of PrestigeStateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalMultiplier = null,Object? currentThreshold = null,Object? currentMultiplier = null,Object? isUnlocked = null,Object? prestigeCount = null,}) {
  return _then(_PrestigeStateModel(
totalMultiplier: null == totalMultiplier ? _self.totalMultiplier : totalMultiplier // ignore: cast_nullable_to_non_nullable
as BigNumber,currentThreshold: null == currentThreshold ? _self.currentThreshold : currentThreshold // ignore: cast_nullable_to_non_nullable
as BigNumber,currentMultiplier: null == currentMultiplier ? _self.currentMultiplier : currentMultiplier // ignore: cast_nullable_to_non_nullable
as BigNumber,isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,prestigeCount: null == prestigeCount ? _self.prestigeCount : prestigeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
