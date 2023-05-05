part of 'merchant_bloc.dart';

class MerchantState extends BaseState<List<Merchant>> {
  const MerchantState(super.data,
      {super.status = StatusState.loading, super.message});

  MerchantState copyWith({
    StatusState? status,
    List<Merchant>? merchants,
    String? message,
  }) =>
      MerchantState(merchants ?? data,
          status: status ?? this.status, message: message ?? this.message);

  @override
  String toString() =>
      'MerchantState(status: $status, data: $data, errorMessage: $message)';
}
