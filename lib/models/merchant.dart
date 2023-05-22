import 'package:antreeorder/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'antree.dart';
import 'product.dart';
import 'seat.dart';

part 'merchant.freezed.dart';
part 'merchant.g.dart';

@freezed
class Merchant with _$Merchant {
  const Merchant._();
  const factory Merchant({
    @Default(0) int id,
    @Default(false) bool isOpen,
    @Default(<Antree>[]) List<Antree> antrees,
    @Default(<Product>[]) List<Product> products,
    @Default(<Seat>[]) List<Seat> seats,
    @Default(User()) User user,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
  }) = _Merchant;

  factory Merchant.fromJson(Map<String, dynamic> json) =>
      _$MerchantFromJson(json);
}
