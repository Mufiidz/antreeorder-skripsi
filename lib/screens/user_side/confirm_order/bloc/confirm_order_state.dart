part of 'confirm_order_bloc.dart';

class ConfirmOrderState extends BaseState<int> {
  final int subtotal;
  final List<Summary> summaries;
  final List<Seat> seats;
  final Seat seat;
  final Antree? antree;
  const ConfirmOrderState(super.data,
      {super.status = StatusState.idle,
      super.message,
      this.subtotal = 0,
      this.summaries = const [],
      this.seats = const [],
      this.seat = const Seat(),
      this.antree});

  @override
  List<Object?> get props =>
      [subtotal, summaries, data, status, message, seats, antree];

  ConfirmOrderState copyWith(
      {int? total,
      int? subtotal,
      StatusState? status,
      String? message,
      List<Summary>? summaries,
      List<Seat>? seats,
      Seat? seat,
      Antree? antree,
      bool? bayarLansung}) {
    return ConfirmOrderState(total ?? data,
        status: status ?? this.status,
        message: message ?? this.message,
        subtotal: subtotal ?? this.subtotal,
        summaries: summaries ?? this.summaries,
        seats: seats ?? this.seats,
        seat: seat ?? this.seat,
        antree: antree ?? this.antree);
  }

  @override
  String toString() =>
      'ConfirmOrderState(subtotal: $subtotal, summaries: $summaries, status: $status, errorMessage: $message, data: $data, seats: $seats, seat: $seat, antree: $antree)';
}
