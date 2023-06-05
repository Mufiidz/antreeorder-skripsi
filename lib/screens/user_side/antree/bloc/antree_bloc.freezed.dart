// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'antree_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AntreeEvent {
  int get antreeId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int antreeId) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int antreeId)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int antreeId)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AntreeEventCopyWith<AntreeEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AntreeEventCopyWith<$Res> {
  factory $AntreeEventCopyWith(
          AntreeEvent value, $Res Function(AntreeEvent) then) =
      _$AntreeEventCopyWithImpl<$Res, AntreeEvent>;
  @useResult
  $Res call({int antreeId});
}

/// @nodoc
class _$AntreeEventCopyWithImpl<$Res, $Val extends AntreeEvent>
    implements $AntreeEventCopyWith<$Res> {
  _$AntreeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? antreeId = null,
  }) {
    return _then(_value.copyWith(
      antreeId: null == antreeId
          ? _value.antreeId
          : antreeId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> implements $AntreeEventCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int antreeId});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$AntreeEventCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? antreeId = null,
  }) {
    return _then(_$_Initial(
      null == antreeId
          ? _value.antreeId
          : antreeId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(this.antreeId);

  @override
  final int antreeId;

  @override
  String toString() {
    return 'AntreeEvent.initial(antreeId: $antreeId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            (identical(other.antreeId, antreeId) ||
                other.antreeId == antreeId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, antreeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int antreeId) initial,
  }) {
    return initial(antreeId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int antreeId)? initial,
  }) {
    return initial?.call(antreeId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int antreeId)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(antreeId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AntreeEvent {
  const factory _Initial(final int antreeId) = _$_Initial;

  @override
  int get antreeId;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AntreeState {
  List<Widget> get sections => throw _privateConstructorUsedError;
  StatusState get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Antree get antree => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AntreeStateCopyWith<AntreeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AntreeStateCopyWith<$Res> {
  factory $AntreeStateCopyWith(
          AntreeState value, $Res Function(AntreeState) then) =
      _$AntreeStateCopyWithImpl<$Res, AntreeState>;
  @useResult
  $Res call(
      {List<Widget> sections,
      StatusState status,
      String message,
      Antree antree});

  $AntreeCopyWith<$Res> get antree;
}

/// @nodoc
class _$AntreeStateCopyWithImpl<$Res, $Val extends AntreeState>
    implements $AntreeStateCopyWith<$Res> {
  _$AntreeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sections = null,
    Object? status = null,
    Object? message = null,
    Object? antree = null,
  }) {
    return _then(_value.copyWith(
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusState,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      antree: null == antree
          ? _value.antree
          : antree // ignore: cast_nullable_to_non_nullable
              as Antree,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AntreeCopyWith<$Res> get antree {
    return $AntreeCopyWith<$Res>(_value.antree, (value) {
      return _then(_value.copyWith(antree: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AntreeStateCopyWith<$Res>
    implements $AntreeStateCopyWith<$Res> {
  factory _$$_AntreeStateCopyWith(
          _$_AntreeState value, $Res Function(_$_AntreeState) then) =
      __$$_AntreeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Widget> sections,
      StatusState status,
      String message,
      Antree antree});

  @override
  $AntreeCopyWith<$Res> get antree;
}

/// @nodoc
class __$$_AntreeStateCopyWithImpl<$Res>
    extends _$AntreeStateCopyWithImpl<$Res, _$_AntreeState>
    implements _$$_AntreeStateCopyWith<$Res> {
  __$$_AntreeStateCopyWithImpl(
      _$_AntreeState _value, $Res Function(_$_AntreeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sections = null,
    Object? status = null,
    Object? message = null,
    Object? antree = null,
  }) {
    return _then(_$_AntreeState(
      sections: null == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusState,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      antree: null == antree
          ? _value.antree
          : antree // ignore: cast_nullable_to_non_nullable
              as Antree,
    ));
  }
}

/// @nodoc

class _$_AntreeState implements _AntreeState {
  const _$_AntreeState(
      {final List<Widget> sections = const [],
      this.status = StatusState.idle,
      this.message = '',
      this.antree = const Antree()})
      : _sections = sections;

  final List<Widget> _sections;
  @override
  @JsonKey()
  List<Widget> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  @JsonKey()
  final StatusState status;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final Antree antree;

  @override
  String toString() {
    return 'AntreeState(sections: $sections, status: $status, message: $message, antree: $antree)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AntreeState &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.antree, antree) || other.antree == antree));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_sections), status, message, antree);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AntreeStateCopyWith<_$_AntreeState> get copyWith =>
      __$$_AntreeStateCopyWithImpl<_$_AntreeState>(this, _$identity);
}

abstract class _AntreeState implements AntreeState {
  const factory _AntreeState(
      {final List<Widget> sections,
      final StatusState status,
      final String message,
      final Antree antree}) = _$_AntreeState;

  @override
  List<Widget> get sections;
  @override
  StatusState get status;
  @override
  String get message;
  @override
  Antree get antree;
  @override
  @JsonKey(ignore: true)
  _$$_AntreeStateCopyWith<_$_AntreeState> get copyWith =>
      throw _privateConstructorUsedError;
}
