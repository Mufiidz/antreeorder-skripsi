// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ContentDetail {
  String get title => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ContentDetailCopyWith<ContentDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentDetailCopyWith<$Res> {
  factory $ContentDetailCopyWith(
          ContentDetail value, $Res Function(ContentDetail) then) =
      _$ContentDetailCopyWithImpl<$Res, ContentDetail>;
  @useResult
  $Res call({String title, String value});
}

/// @nodoc
class _$ContentDetailCopyWithImpl<$Res, $Val extends ContentDetail>
    implements $ContentDetailCopyWith<$Res> {
  _$ContentDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ContentDetailCopyWith<$Res>
    implements $ContentDetailCopyWith<$Res> {
  factory _$$_ContentDetailCopyWith(
          _$_ContentDetail value, $Res Function(_$_ContentDetail) then) =
      __$$_ContentDetailCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String value});
}

/// @nodoc
class __$$_ContentDetailCopyWithImpl<$Res>
    extends _$ContentDetailCopyWithImpl<$Res, _$_ContentDetail>
    implements _$$_ContentDetailCopyWith<$Res> {
  __$$_ContentDetailCopyWithImpl(
      _$_ContentDetail _value, $Res Function(_$_ContentDetail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? value = null,
  }) {
    return _then(_$_ContentDetail(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ContentDetail implements _ContentDetail {
  _$_ContentDetail({this.title = '', this.value = ''});

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String value;

  @override
  String toString() {
    return 'ContentDetail(title: $title, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ContentDetail &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ContentDetailCopyWith<_$_ContentDetail> get copyWith =>
      __$$_ContentDetailCopyWithImpl<_$_ContentDetail>(this, _$identity);
}

abstract class _ContentDetail implements ContentDetail {
  factory _ContentDetail({final String title, final String value}) =
      _$_ContentDetail;

  @override
  String get title;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$_ContentDetailCopyWith<_$_ContentDetail> get copyWith =>
      throw _privateConstructorUsedError;
}
