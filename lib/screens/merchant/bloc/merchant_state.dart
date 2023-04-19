part of 'merchant_bloc.dart';

class MerchantState extends BaseState<List<Merchant>> {
  const MerchantState(super.data,
      {super.status = StatusState.loading, super.errorMessage = ''});

  MerchantState copyWith({
    StatusState? status,
    List<Merchant>? merchants,
    String? errorMessage,
  }) =>
      MerchantState(merchants ?? data,
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  String toString() =>
      'MerchantState(status: $status, data: $data, errorMessage: $errorMessage)';
}
