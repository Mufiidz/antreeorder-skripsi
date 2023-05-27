part of 'detail_antree_merchant_bloc.dart';

@freezed
class DetailAntreeMerchantEvent with _$DetailAntreeMerchantEvent {
  const factory DetailAntreeMerchantEvent.initial(Antree antree) =
      _DetailAntreeMerchantInitial;
  const factory DetailAntreeMerchantEvent.confirmAntree(Antree antree) =
      _DetailAntreeMerchantConfirmAntree;
  const factory DetailAntreeMerchantEvent.cancelAntree(Antree antree) =
      _DetailAntreeMerchantCancelAntree;
  const factory DetailAntreeMerchantEvent.updateStatus(Antree antree) =
      _DetailAntreeMerchantUpdateStatus;
}
