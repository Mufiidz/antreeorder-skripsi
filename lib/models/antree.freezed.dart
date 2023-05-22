// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'antree.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Antree _$AntreeFromJson(Map<String, dynamic> json) {
  return _Antree.fromJson(json);
}

/// @nodoc
mixin _$Antree {
  int get id => throw _privateConstructorUsedError;
  int get merchantId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  int get totalPrice => throw _privateConstructorUsedError;
  List<Order> get orders => throw _privateConstructorUsedError;
  StatusAntree get status => throw _privateConstructorUsedError;
  bool get isVerify => throw _privateConstructorUsedError;
  @JsonKey(name: 'nomor_antri')
  int get antreeNum => throw _privateConstructorUsedError;
  int get remaining => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  Merchant get merchant => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AntreeCopyWith<Antree> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AntreeCopyWith<$Res> {
  factory $AntreeCopyWith(Antree value, $Res Function(Antree) then) =
      _$AntreeCopyWithImpl<$Res, Antree>;
  @useResult
  $Res call(
      {int id,
      int merchantId,
      int userId,
      int totalPrice,
      List<Order> orders,
      StatusAntree status,
      bool isVerify,
      @JsonKey(name: 'nomor_antri') int antreeNum,
      int remaining,
      DateTime? createdAt,
      DateTime? updatedAt,
      Merchant merchant});

  $MerchantCopyWith<$Res> get merchant;
}

/// @nodoc
class _$AntreeCopyWithImpl<$Res, $Val extends Antree>
    implements $AntreeCopyWith<$Res> {
  _$AntreeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? merchantId = null,
    Object? userId = null,
    Object? totalPrice = null,
    Object? orders = null,
    Object? status = null,
    Object? isVerify = null,
    Object? antreeNum = null,
    Object? remaining = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? merchant = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      merchantId: null == merchantId
          ? _value.merchantId
          : merchantId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as int,
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusAntree,
      isVerify: null == isVerify
          ? _value.isVerify
          : isVerify // ignore: cast_nullable_to_non_nullable
              as bool,
      antreeNum: null == antreeNum
          ? _value.antreeNum
          : antreeNum // ignore: cast_nullable_to_non_nullable
              as int,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      merchant: null == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as Merchant,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MerchantCopyWith<$Res> get merchant {
    return $MerchantCopyWith<$Res>(_value.merchant, (value) {
      return _then(_value.copyWith(merchant: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AntreeCopyWith<$Res> implements $AntreeCopyWith<$Res> {
  factory _$$_AntreeCopyWith(_$_Antree value, $Res Function(_$_Antree) then) =
      __$$_AntreeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int merchantId,
      int userId,
      int totalPrice,
      List<Order> orders,
      StatusAntree status,
      bool isVerify,
      @JsonKey(name: 'nomor_antri') int antreeNum,
      int remaining,
      DateTime? createdAt,
      DateTime? updatedAt,
      Merchant merchant});

  @override
  $MerchantCopyWith<$Res> get merchant;
}

/// @nodoc
class __$$_AntreeCopyWithImpl<$Res>
    extends _$AntreeCopyWithImpl<$Res, _$_Antree>
    implements _$$_AntreeCopyWith<$Res> {
  __$$_AntreeCopyWithImpl(_$_Antree _value, $Res Function(_$_Antree) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? merchantId = null,
    Object? userId = null,
    Object? totalPrice = null,
    Object? orders = null,
    Object? status = null,
    Object? isVerify = null,
    Object? antreeNum = null,
    Object? remaining = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? merchant = null,
  }) {
    return _then(_$_Antree(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      merchantId: null == merchantId
          ? _value.merchantId
          : merchantId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as int,
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusAntree,
      isVerify: null == isVerify
          ? _value.isVerify
          : isVerify // ignore: cast_nullable_to_non_nullable
              as bool,
      antreeNum: null == antreeNum
          ? _value.antreeNum
          : antreeNum // ignore: cast_nullable_to_non_nullable
              as int,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      merchant: null == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as Merchant,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Antree implements _Antree {
  _$_Antree(
      {this.id = 0,
      this.merchantId = 0,
      this.userId = 0,
      this.totalPrice = 0,
      final List<Order> orders = const [],
      this.status = const StatusAntree(),
      this.isVerify = false,
      @JsonKey(name: 'nomor_antri') this.antreeNum = 0,
      this.remaining = 0,
      this.createdAt,
      this.updatedAt,
      this.merchant = const Merchant()})
      : _orders = orders;

  factory _$_Antree.fromJson(Map<String, dynamic> json) =>
      _$$_AntreeFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int merchantId;
  @override
  @JsonKey()
  final int userId;
  @override
  @JsonKey()
  final int totalPrice;
  final List<Order> _orders;
  @override
  @JsonKey()
  List<Order> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  @JsonKey()
  final StatusAntree status;
  @override
  @JsonKey()
  final bool isVerify;
  @override
  @JsonKey(name: 'nomor_antri')
  final int antreeNum;
  @override
  @JsonKey()
  final int remaining;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final Merchant merchant;

  @override
  String toString() {
    return 'Antree(id: $id, merchantId: $merchantId, userId: $userId, totalPrice: $totalPrice, orders: $orders, status: $status, isVerify: $isVerify, antreeNum: $antreeNum, remaining: $remaining, createdAt: $createdAt, updatedAt: $updatedAt, merchant: $merchant)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Antree &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.merchantId, merchantId) ||
                other.merchantId == merchantId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            const DeepCollectionEquality().equals(other._orders, _orders) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isVerify, isVerify) ||
                other.isVerify == isVerify) &&
            (identical(other.antreeNum, antreeNum) ||
                other.antreeNum == antreeNum) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      merchantId,
      userId,
      totalPrice,
      const DeepCollectionEquality().hash(_orders),
      status,
      isVerify,
      antreeNum,
      remaining,
      createdAt,
      updatedAt,
      merchant);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AntreeCopyWith<_$_Antree> get copyWith =>
      __$$_AntreeCopyWithImpl<_$_Antree>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AntreeToJson(
      this,
    );
  }
}

abstract class _Antree implements Antree {
  factory _Antree(
      {final int id,
      final int merchantId,
      final int userId,
      final int totalPrice,
      final List<Order> orders,
      final StatusAntree status,
      final bool isVerify,
      @JsonKey(name: 'nomor_antri') final int antreeNum,
      final int remaining,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final Merchant merchant}) = _$_Antree;

  factory _Antree.fromJson(Map<String, dynamic> json) = _$_Antree.fromJson;

  @override
  int get id;
  @override
  int get merchantId;
  @override
  int get userId;
  @override
  int get totalPrice;
  @override
  List<Order> get orders;
  @override
  StatusAntree get status;
  @override
  bool get isVerify;
  @override
  @JsonKey(name: 'nomor_antri')
  int get antreeNum;
  @override
  int get remaining;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  Merchant get merchant;
  @override
  @JsonKey(ignore: true)
  _$$_AntreeCopyWith<_$_Antree> get copyWith =>
      throw _privateConstructorUsedError;
}
