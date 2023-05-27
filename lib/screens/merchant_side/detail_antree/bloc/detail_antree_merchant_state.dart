part of 'detail_antree_merchant_bloc.dart';

@freezed
class DetailAntreeMerchantState with _$DetailAntreeMerchantState {
  const factory DetailAntreeMerchantState(
      {@Default(StatusState.idle) StatusState status,
      @Default('') String message,
      @Default(Antree()) Antree antree,
      DetailAntreeButton? detailAntreeButton}) = _DetailAntreeMerchantState;
}

class DetailAntreeButton {
  final int statusId;
  final String positiveButtonText;
  final String negativeButtonText;
  final DetailAntreeBtnAction? positiveActionButton;
  final DetailAntreeBtnAction? negativeActionButton;

  const DetailAntreeButton({
    this.statusId = 0,
    this.positiveButtonText = '-',
    this.negativeButtonText = '-',
    this.positiveActionButton,
    this.negativeActionButton,
  });
}

enum DetailAntreeBtnAction {
  confirm,
  cancel,
  increase,
  decrease,
  alihkan,
  diambil
}
