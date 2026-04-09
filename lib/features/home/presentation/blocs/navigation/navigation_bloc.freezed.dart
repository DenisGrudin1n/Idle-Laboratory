// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NavigationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NavigationEvent()';
}


}

/// @nodoc
class $NavigationEventCopyWith<$Res>  {
$NavigationEventCopyWith(NavigationEvent _, $Res Function(NavigationEvent) __);
}


/// Adds pattern-matching-related methods to [NavigationEvent].
extension NavigationEventPatterns on NavigationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _MainTabChanged value)?  mainTabChanged,TResult Function( _CellsTabChanged value)?  cellsTabChanged,TResult Function( _CraftingTabChanged value)?  craftingTabChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MainTabChanged() when mainTabChanged != null:
return mainTabChanged(_that);case _CellsTabChanged() when cellsTabChanged != null:
return cellsTabChanged(_that);case _CraftingTabChanged() when craftingTabChanged != null:
return craftingTabChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _MainTabChanged value)  mainTabChanged,required TResult Function( _CellsTabChanged value)  cellsTabChanged,required TResult Function( _CraftingTabChanged value)  craftingTabChanged,}){
final _that = this;
switch (_that) {
case _MainTabChanged():
return mainTabChanged(_that);case _CellsTabChanged():
return cellsTabChanged(_that);case _CraftingTabChanged():
return craftingTabChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _MainTabChanged value)?  mainTabChanged,TResult? Function( _CellsTabChanged value)?  cellsTabChanged,TResult? Function( _CraftingTabChanged value)?  craftingTabChanged,}){
final _that = this;
switch (_that) {
case _MainTabChanged() when mainTabChanged != null:
return mainTabChanged(_that);case _CellsTabChanged() when cellsTabChanged != null:
return cellsTabChanged(_that);case _CraftingTabChanged() when craftingTabChanged != null:
return craftingTabChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( MainNavigationTab mainTab)?  mainTabChanged,TResult Function( CellsTab cellsTab)?  cellsTabChanged,TResult Function( CraftingTab craftingTab)?  craftingTabChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MainTabChanged() when mainTabChanged != null:
return mainTabChanged(_that.mainTab);case _CellsTabChanged() when cellsTabChanged != null:
return cellsTabChanged(_that.cellsTab);case _CraftingTabChanged() when craftingTabChanged != null:
return craftingTabChanged(_that.craftingTab);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( MainNavigationTab mainTab)  mainTabChanged,required TResult Function( CellsTab cellsTab)  cellsTabChanged,required TResult Function( CraftingTab craftingTab)  craftingTabChanged,}) {final _that = this;
switch (_that) {
case _MainTabChanged():
return mainTabChanged(_that.mainTab);case _CellsTabChanged():
return cellsTabChanged(_that.cellsTab);case _CraftingTabChanged():
return craftingTabChanged(_that.craftingTab);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( MainNavigationTab mainTab)?  mainTabChanged,TResult? Function( CellsTab cellsTab)?  cellsTabChanged,TResult? Function( CraftingTab craftingTab)?  craftingTabChanged,}) {final _that = this;
switch (_that) {
case _MainTabChanged() when mainTabChanged != null:
return mainTabChanged(_that.mainTab);case _CellsTabChanged() when cellsTabChanged != null:
return cellsTabChanged(_that.cellsTab);case _CraftingTabChanged() when craftingTabChanged != null:
return craftingTabChanged(_that.craftingTab);case _:
  return null;

}
}

}

/// @nodoc


class _MainTabChanged implements NavigationEvent {
  const _MainTabChanged(this.mainTab);
  

 final  MainNavigationTab mainTab;

/// Create a copy of NavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MainTabChangedCopyWith<_MainTabChanged> get copyWith => __$MainTabChangedCopyWithImpl<_MainTabChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MainTabChanged&&(identical(other.mainTab, mainTab) || other.mainTab == mainTab));
}


@override
int get hashCode => Object.hash(runtimeType,mainTab);

@override
String toString() {
  return 'NavigationEvent.mainTabChanged(mainTab: $mainTab)';
}


}

/// @nodoc
abstract mixin class _$MainTabChangedCopyWith<$Res> implements $NavigationEventCopyWith<$Res> {
  factory _$MainTabChangedCopyWith(_MainTabChanged value, $Res Function(_MainTabChanged) _then) = __$MainTabChangedCopyWithImpl;
@useResult
$Res call({
 MainNavigationTab mainTab
});




}
/// @nodoc
class __$MainTabChangedCopyWithImpl<$Res>
    implements _$MainTabChangedCopyWith<$Res> {
  __$MainTabChangedCopyWithImpl(this._self, this._then);

  final _MainTabChanged _self;
  final $Res Function(_MainTabChanged) _then;

/// Create a copy of NavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mainTab = null,}) {
  return _then(_MainTabChanged(
null == mainTab ? _self.mainTab : mainTab // ignore: cast_nullable_to_non_nullable
as MainNavigationTab,
  ));
}


}

/// @nodoc


class _CellsTabChanged implements NavigationEvent {
  const _CellsTabChanged(this.cellsTab);
  

 final  CellsTab cellsTab;

/// Create a copy of NavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CellsTabChangedCopyWith<_CellsTabChanged> get copyWith => __$CellsTabChangedCopyWithImpl<_CellsTabChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CellsTabChanged&&(identical(other.cellsTab, cellsTab) || other.cellsTab == cellsTab));
}


@override
int get hashCode => Object.hash(runtimeType,cellsTab);

@override
String toString() {
  return 'NavigationEvent.cellsTabChanged(cellsTab: $cellsTab)';
}


}

/// @nodoc
abstract mixin class _$CellsTabChangedCopyWith<$Res> implements $NavigationEventCopyWith<$Res> {
  factory _$CellsTabChangedCopyWith(_CellsTabChanged value, $Res Function(_CellsTabChanged) _then) = __$CellsTabChangedCopyWithImpl;
@useResult
$Res call({
 CellsTab cellsTab
});




}
/// @nodoc
class __$CellsTabChangedCopyWithImpl<$Res>
    implements _$CellsTabChangedCopyWith<$Res> {
  __$CellsTabChangedCopyWithImpl(this._self, this._then);

  final _CellsTabChanged _self;
  final $Res Function(_CellsTabChanged) _then;

/// Create a copy of NavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cellsTab = null,}) {
  return _then(_CellsTabChanged(
null == cellsTab ? _self.cellsTab : cellsTab // ignore: cast_nullable_to_non_nullable
as CellsTab,
  ));
}


}

/// @nodoc


class _CraftingTabChanged implements NavigationEvent {
  const _CraftingTabChanged(this.craftingTab);
  

 final  CraftingTab craftingTab;

/// Create a copy of NavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CraftingTabChangedCopyWith<_CraftingTabChanged> get copyWith => __$CraftingTabChangedCopyWithImpl<_CraftingTabChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CraftingTabChanged&&(identical(other.craftingTab, craftingTab) || other.craftingTab == craftingTab));
}


@override
int get hashCode => Object.hash(runtimeType,craftingTab);

@override
String toString() {
  return 'NavigationEvent.craftingTabChanged(craftingTab: $craftingTab)';
}


}

/// @nodoc
abstract mixin class _$CraftingTabChangedCopyWith<$Res> implements $NavigationEventCopyWith<$Res> {
  factory _$CraftingTabChangedCopyWith(_CraftingTabChanged value, $Res Function(_CraftingTabChanged) _then) = __$CraftingTabChangedCopyWithImpl;
@useResult
$Res call({
 CraftingTab craftingTab
});




}
/// @nodoc
class __$CraftingTabChangedCopyWithImpl<$Res>
    implements _$CraftingTabChangedCopyWith<$Res> {
  __$CraftingTabChangedCopyWithImpl(this._self, this._then);

  final _CraftingTabChanged _self;
  final $Res Function(_CraftingTabChanged) _then;

/// Create a copy of NavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? craftingTab = null,}) {
  return _then(_CraftingTabChanged(
null == craftingTab ? _self.craftingTab : craftingTab // ignore: cast_nullable_to_non_nullable
as CraftingTab,
  ));
}


}

/// @nodoc
mixin _$NavigationState {

 MainNavigationTab get mainTab; CellsTab get cellsTab; CraftingTab get craftingTab;
/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationStateCopyWith<NavigationState> get copyWith => _$NavigationStateCopyWithImpl<NavigationState>(this as NavigationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationState&&(identical(other.mainTab, mainTab) || other.mainTab == mainTab)&&(identical(other.cellsTab, cellsTab) || other.cellsTab == cellsTab)&&(identical(other.craftingTab, craftingTab) || other.craftingTab == craftingTab));
}


@override
int get hashCode => Object.hash(runtimeType,mainTab,cellsTab,craftingTab);

@override
String toString() {
  return 'NavigationState(mainTab: $mainTab, cellsTab: $cellsTab, craftingTab: $craftingTab)';
}


}

/// @nodoc
abstract mixin class $NavigationStateCopyWith<$Res>  {
  factory $NavigationStateCopyWith(NavigationState value, $Res Function(NavigationState) _then) = _$NavigationStateCopyWithImpl;
@useResult
$Res call({
 MainNavigationTab mainTab, CellsTab cellsTab, CraftingTab craftingTab
});




}
/// @nodoc
class _$NavigationStateCopyWithImpl<$Res>
    implements $NavigationStateCopyWith<$Res> {
  _$NavigationStateCopyWithImpl(this._self, this._then);

  final NavigationState _self;
  final $Res Function(NavigationState) _then;

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mainTab = null,Object? cellsTab = null,Object? craftingTab = null,}) {
  return _then(_self.copyWith(
mainTab: null == mainTab ? _self.mainTab : mainTab // ignore: cast_nullable_to_non_nullable
as MainNavigationTab,cellsTab: null == cellsTab ? _self.cellsTab : cellsTab // ignore: cast_nullable_to_non_nullable
as CellsTab,craftingTab: null == craftingTab ? _self.craftingTab : craftingTab // ignore: cast_nullable_to_non_nullable
as CraftingTab,
  ));
}

}


/// Adds pattern-matching-related methods to [NavigationState].
extension NavigationStatePatterns on NavigationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigationState value)  $default,){
final _that = this;
switch (_that) {
case _NavigationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavigationState value)?  $default,){
final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MainNavigationTab mainTab,  CellsTab cellsTab,  CraftingTab craftingTab)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
return $default(_that.mainTab,_that.cellsTab,_that.craftingTab);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MainNavigationTab mainTab,  CellsTab cellsTab,  CraftingTab craftingTab)  $default,) {final _that = this;
switch (_that) {
case _NavigationState():
return $default(_that.mainTab,_that.cellsTab,_that.craftingTab);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MainNavigationTab mainTab,  CellsTab cellsTab,  CraftingTab craftingTab)?  $default,) {final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
return $default(_that.mainTab,_that.cellsTab,_that.craftingTab);case _:
  return null;

}
}

}

/// @nodoc


class _NavigationState implements NavigationState {
  const _NavigationState({this.mainTab = MainNavigationTab.cells, this.cellsTab = CellsTab.energyCells, this.craftingTab = CraftingTab.crafting});
  

@override@JsonKey() final  MainNavigationTab mainTab;
@override@JsonKey() final  CellsTab cellsTab;
@override@JsonKey() final  CraftingTab craftingTab;

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigationStateCopyWith<_NavigationState> get copyWith => __$NavigationStateCopyWithImpl<_NavigationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigationState&&(identical(other.mainTab, mainTab) || other.mainTab == mainTab)&&(identical(other.cellsTab, cellsTab) || other.cellsTab == cellsTab)&&(identical(other.craftingTab, craftingTab) || other.craftingTab == craftingTab));
}


@override
int get hashCode => Object.hash(runtimeType,mainTab,cellsTab,craftingTab);

@override
String toString() {
  return 'NavigationState(mainTab: $mainTab, cellsTab: $cellsTab, craftingTab: $craftingTab)';
}


}

/// @nodoc
abstract mixin class _$NavigationStateCopyWith<$Res> implements $NavigationStateCopyWith<$Res> {
  factory _$NavigationStateCopyWith(_NavigationState value, $Res Function(_NavigationState) _then) = __$NavigationStateCopyWithImpl;
@override @useResult
$Res call({
 MainNavigationTab mainTab, CellsTab cellsTab, CraftingTab craftingTab
});




}
/// @nodoc
class __$NavigationStateCopyWithImpl<$Res>
    implements _$NavigationStateCopyWith<$Res> {
  __$NavigationStateCopyWithImpl(this._self, this._then);

  final _NavigationState _self;
  final $Res Function(_NavigationState) _then;

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mainTab = null,Object? cellsTab = null,Object? craftingTab = null,}) {
  return _then(_NavigationState(
mainTab: null == mainTab ? _self.mainTab : mainTab // ignore: cast_nullable_to_non_nullable
as MainNavigationTab,cellsTab: null == cellsTab ? _self.cellsTab : cellsTab // ignore: cast_nullable_to_non_nullable
as CellsTab,craftingTab: null == craftingTab ? _self.craftingTab : craftingTab // ignore: cast_nullable_to_non_nullable
as CraftingTab,
  ));
}


}

// dart format on
