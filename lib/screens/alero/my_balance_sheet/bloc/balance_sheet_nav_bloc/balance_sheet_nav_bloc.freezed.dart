// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance_sheet_nav_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BalanceSheetNavState {
  bool get active => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BalanceSheetNavStateCopyWith<BalanceSheetNavState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceSheetNavStateCopyWith<$Res> {
  factory $BalanceSheetNavStateCopyWith(BalanceSheetNavState value,
          $Res Function(BalanceSheetNavState) then) =
      _$BalanceSheetNavStateCopyWithImpl<$Res, BalanceSheetNavState>;
  @useResult
  $Res call({bool active, bool isActive, int position});
}

/// @nodoc
class _$BalanceSheetNavStateCopyWithImpl<$Res,
        $Val extends BalanceSheetNavState>
    implements $BalanceSheetNavStateCopyWith<$Res> {
  _$BalanceSheetNavStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? active = null,
    Object? isActive = null,
    Object? position = null,
  }) {
    return _then(_value.copyWith(
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BalanceSheetNavStateCopyWith<$Res>
    implements $BalanceSheetNavStateCopyWith<$Res> {
  factory _$$_BalanceSheetNavStateCopyWith(_$_BalanceSheetNavState value,
          $Res Function(_$_BalanceSheetNavState) then) =
      __$$_BalanceSheetNavStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool active, bool isActive, int position});
}

/// @nodoc
class __$$_BalanceSheetNavStateCopyWithImpl<$Res>
    extends _$BalanceSheetNavStateCopyWithImpl<$Res, _$_BalanceSheetNavState>
    implements _$$_BalanceSheetNavStateCopyWith<$Res> {
  __$$_BalanceSheetNavStateCopyWithImpl(_$_BalanceSheetNavState _value,
      $Res Function(_$_BalanceSheetNavState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? active = null,
    Object? isActive = null,
    Object? position = null,
  }) {
    return _then(_$_BalanceSheetNavState(
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_BalanceSheetNavState implements _BalanceSheetNavState {
  const _$_BalanceSheetNavState(
      {required this.active, required this.isActive, required this.position});

  @override
  final bool active;
  @override
  final bool isActive;
  @override
  final int position;

  @override
  String toString() {
    return 'BalanceSheetNavState(active: $active, isActive: $isActive, position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BalanceSheetNavState &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, active, isActive, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BalanceSheetNavStateCopyWith<_$_BalanceSheetNavState> get copyWith =>
      __$$_BalanceSheetNavStateCopyWithImpl<_$_BalanceSheetNavState>(
          this, _$identity);
}

abstract class _BalanceSheetNavState implements BalanceSheetNavState {
  const factory _BalanceSheetNavState(
      {required final bool active,
      required final bool isActive,
      required final int position}) = _$_BalanceSheetNavState;

  @override
  bool get active;
  @override
  bool get isActive;
  @override
  int get position;
  @override
  @JsonKey(ignore: true)
  _$$_BalanceSheetNavStateCopyWith<_$_BalanceSheetNavState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BalanceSheetNavEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool active) activeChanged,
    required TResult Function(bool isActive) isActiveChanged,
    required TResult Function(int position) positionChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool active)? activeChanged,
    TResult? Function(bool isActive)? isActiveChanged,
    TResult? Function(int position)? positionChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool active)? activeChanged,
    TResult Function(bool isActive)? isActiveChanged,
    TResult Function(int position)? positionChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveChanged value) activeChanged,
    required TResult Function(IsActiveChanged value) isActiveChanged,
    required TResult Function(PositionChanged value) positionChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveChanged value)? activeChanged,
    TResult? Function(IsActiveChanged value)? isActiveChanged,
    TResult? Function(PositionChanged value)? positionChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveChanged value)? activeChanged,
    TResult Function(IsActiveChanged value)? isActiveChanged,
    TResult Function(PositionChanged value)? positionChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceSheetNavEventCopyWith<$Res> {
  factory $BalanceSheetNavEventCopyWith(BalanceSheetNavEvent value,
          $Res Function(BalanceSheetNavEvent) then) =
      _$BalanceSheetNavEventCopyWithImpl<$Res, BalanceSheetNavEvent>;
}

/// @nodoc
class _$BalanceSheetNavEventCopyWithImpl<$Res,
        $Val extends BalanceSheetNavEvent>
    implements $BalanceSheetNavEventCopyWith<$Res> {
  _$BalanceSheetNavEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ActiveChangedCopyWith<$Res> {
  factory _$$ActiveChangedCopyWith(
          _$ActiveChanged value, $Res Function(_$ActiveChanged) then) =
      __$$ActiveChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({bool active});
}

/// @nodoc
class __$$ActiveChangedCopyWithImpl<$Res>
    extends _$BalanceSheetNavEventCopyWithImpl<$Res, _$ActiveChanged>
    implements _$$ActiveChangedCopyWith<$Res> {
  __$$ActiveChangedCopyWithImpl(
      _$ActiveChanged _value, $Res Function(_$ActiveChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? active = null,
  }) {
    return _then(_$ActiveChanged(
      null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ActiveChanged implements ActiveChanged {
  const _$ActiveChanged(this.active);

  @override
  final bool active;

  @override
  String toString() {
    return 'BalanceSheetNavEvent.activeChanged(active: $active)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveChanged &&
            (identical(other.active, active) || other.active == active));
  }

  @override
  int get hashCode => Object.hash(runtimeType, active);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveChangedCopyWith<_$ActiveChanged> get copyWith =>
      __$$ActiveChangedCopyWithImpl<_$ActiveChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool active) activeChanged,
    required TResult Function(bool isActive) isActiveChanged,
    required TResult Function(int position) positionChanged,
  }) {
    return activeChanged(active);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool active)? activeChanged,
    TResult? Function(bool isActive)? isActiveChanged,
    TResult? Function(int position)? positionChanged,
  }) {
    return activeChanged?.call(active);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool active)? activeChanged,
    TResult Function(bool isActive)? isActiveChanged,
    TResult Function(int position)? positionChanged,
    required TResult orElse(),
  }) {
    if (activeChanged != null) {
      return activeChanged(active);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveChanged value) activeChanged,
    required TResult Function(IsActiveChanged value) isActiveChanged,
    required TResult Function(PositionChanged value) positionChanged,
  }) {
    return activeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveChanged value)? activeChanged,
    TResult? Function(IsActiveChanged value)? isActiveChanged,
    TResult? Function(PositionChanged value)? positionChanged,
  }) {
    return activeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveChanged value)? activeChanged,
    TResult Function(IsActiveChanged value)? isActiveChanged,
    TResult Function(PositionChanged value)? positionChanged,
    required TResult orElse(),
  }) {
    if (activeChanged != null) {
      return activeChanged(this);
    }
    return orElse();
  }
}

abstract class ActiveChanged implements BalanceSheetNavEvent {
  const factory ActiveChanged(final bool active) = _$ActiveChanged;

  bool get active;
  @JsonKey(ignore: true)
  _$$ActiveChangedCopyWith<_$ActiveChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IsActiveChangedCopyWith<$Res> {
  factory _$$IsActiveChangedCopyWith(
          _$IsActiveChanged value, $Res Function(_$IsActiveChanged) then) =
      __$$IsActiveChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isActive});
}

/// @nodoc
class __$$IsActiveChangedCopyWithImpl<$Res>
    extends _$BalanceSheetNavEventCopyWithImpl<$Res, _$IsActiveChanged>
    implements _$$IsActiveChangedCopyWith<$Res> {
  __$$IsActiveChangedCopyWithImpl(
      _$IsActiveChanged _value, $Res Function(_$IsActiveChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActive = null,
  }) {
    return _then(_$IsActiveChanged(
      null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$IsActiveChanged implements IsActiveChanged {
  const _$IsActiveChanged(this.isActive);

  @override
  final bool isActive;

  @override
  String toString() {
    return 'BalanceSheetNavEvent.isActiveChanged(isActive: $isActive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IsActiveChanged &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IsActiveChangedCopyWith<_$IsActiveChanged> get copyWith =>
      __$$IsActiveChangedCopyWithImpl<_$IsActiveChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool active) activeChanged,
    required TResult Function(bool isActive) isActiveChanged,
    required TResult Function(int position) positionChanged,
  }) {
    return isActiveChanged(isActive);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool active)? activeChanged,
    TResult? Function(bool isActive)? isActiveChanged,
    TResult? Function(int position)? positionChanged,
  }) {
    return isActiveChanged?.call(isActive);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool active)? activeChanged,
    TResult Function(bool isActive)? isActiveChanged,
    TResult Function(int position)? positionChanged,
    required TResult orElse(),
  }) {
    if (isActiveChanged != null) {
      return isActiveChanged(isActive);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveChanged value) activeChanged,
    required TResult Function(IsActiveChanged value) isActiveChanged,
    required TResult Function(PositionChanged value) positionChanged,
  }) {
    return isActiveChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveChanged value)? activeChanged,
    TResult? Function(IsActiveChanged value)? isActiveChanged,
    TResult? Function(PositionChanged value)? positionChanged,
  }) {
    return isActiveChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveChanged value)? activeChanged,
    TResult Function(IsActiveChanged value)? isActiveChanged,
    TResult Function(PositionChanged value)? positionChanged,
    required TResult orElse(),
  }) {
    if (isActiveChanged != null) {
      return isActiveChanged(this);
    }
    return orElse();
  }
}

abstract class IsActiveChanged implements BalanceSheetNavEvent {
  const factory IsActiveChanged(final bool isActive) = _$IsActiveChanged;

  bool get isActive;
  @JsonKey(ignore: true)
  _$$IsActiveChangedCopyWith<_$IsActiveChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PositionChangedCopyWith<$Res> {
  factory _$$PositionChangedCopyWith(
          _$PositionChanged value, $Res Function(_$PositionChanged) then) =
      __$$PositionChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({int position});
}

/// @nodoc
class __$$PositionChangedCopyWithImpl<$Res>
    extends _$BalanceSheetNavEventCopyWithImpl<$Res, _$PositionChanged>
    implements _$$PositionChangedCopyWith<$Res> {
  __$$PositionChangedCopyWithImpl(
      _$PositionChanged _value, $Res Function(_$PositionChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
  }) {
    return _then(_$PositionChanged(
      null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PositionChanged implements PositionChanged {
  const _$PositionChanged(this.position);

  @override
  final int position;

  @override
  String toString() {
    return 'BalanceSheetNavEvent.positionChanged(position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PositionChanged &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PositionChangedCopyWith<_$PositionChanged> get copyWith =>
      __$$PositionChangedCopyWithImpl<_$PositionChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool active) activeChanged,
    required TResult Function(bool isActive) isActiveChanged,
    required TResult Function(int position) positionChanged,
  }) {
    return positionChanged(position);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool active)? activeChanged,
    TResult? Function(bool isActive)? isActiveChanged,
    TResult? Function(int position)? positionChanged,
  }) {
    return positionChanged?.call(position);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool active)? activeChanged,
    TResult Function(bool isActive)? isActiveChanged,
    TResult Function(int position)? positionChanged,
    required TResult orElse(),
  }) {
    if (positionChanged != null) {
      return positionChanged(position);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveChanged value) activeChanged,
    required TResult Function(IsActiveChanged value) isActiveChanged,
    required TResult Function(PositionChanged value) positionChanged,
  }) {
    return positionChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveChanged value)? activeChanged,
    TResult? Function(IsActiveChanged value)? isActiveChanged,
    TResult? Function(PositionChanged value)? positionChanged,
  }) {
    return positionChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveChanged value)? activeChanged,
    TResult Function(IsActiveChanged value)? isActiveChanged,
    TResult Function(PositionChanged value)? positionChanged,
    required TResult orElse(),
  }) {
    if (positionChanged != null) {
      return positionChanged(this);
    }
    return orElse();
  }
}

abstract class PositionChanged implements BalanceSheetNavEvent {
  const factory PositionChanged(final int position) = _$PositionChanged;

  int get position;
  @JsonKey(ignore: true)
  _$$PositionChangedCopyWith<_$PositionChanged> get copyWith =>
      throw _privateConstructorUsedError;
}
