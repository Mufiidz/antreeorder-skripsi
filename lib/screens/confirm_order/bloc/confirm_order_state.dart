part of 'confirm_order_bloc.dart';

class ConfirmOrderState extends BaseState<int> {
  final int subtotal;
  final List<Summary> summaries;
  const ConfirmOrderState(super.data,
      {super.status = StatusState.loading,
      super.errorMessage = '',
      this.subtotal = 0,
      this.summaries = const []});

  @override
  List<Object> get props => [subtotal];

  ConfirmOrderState copyWith({
    int? total,
    int? subtotal,
    StatusState? status,
    String? errorMessage,
    List<Summary>? summaries,
  }) {
    return ConfirmOrderState(total ?? data,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        subtotal: subtotal ?? this.subtotal,
        summaries: summaries ?? this.summaries);
  }

  @override
  String toString() =>
      'ConfirmOrderState(subtotal: $subtotal, summaries: $summaries)';
}
