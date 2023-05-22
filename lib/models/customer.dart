import 'package:freezed_annotation/freezed_annotation.dart';

import 'antree.dart';
import 'user.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  const Customer._();
  const factory Customer(
      {@Default(User()) User user,
      @Default(0) int id,
      @Default(<Antree>[]) List<Antree> antrees}) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
