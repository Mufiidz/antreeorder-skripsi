part of 'confirm_order_bloc.dart';

class ConfirmOrderState extends BaseState<int> {
  final int subtotal;
  final List<Summary> summaries;
  const ConfirmOrderState(super.data,
      {super.status = StatusState.loading,
      super.message,
      this.subtotal = 0,
      this.summaries = const []});

  @override
  List<Object> get props => [
        subtotal,
        summaries,
        data,
        status,
        message,
      ];

  ConfirmOrderState copyWith({
    int? total,
    int? subtotal,
    StatusState? status,
    String? message,
    List<Summary>? summaries,
  }) {
    return ConfirmOrderState(total ?? data,
        status: status ?? this.status,
        message: message ?? this.message,
        subtotal: subtotal ?? this.subtotal,
        summaries: summaries ?? this.summaries);
  }

  @override
  String toString() =>
      'ConfirmOrderState(subtotal: $subtotal, summaries: $summaries, status: $status, errorMessage: $message, data: $data)';
}
