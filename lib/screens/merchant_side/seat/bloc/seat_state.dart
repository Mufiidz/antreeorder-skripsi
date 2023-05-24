part of 'seat_bloc.dart';

@freezed
class SeatState with _$SeatState {
  const factory SeatState({
    @Default([]) List<Seat> data,
    @Default(StatusState.idle) StatusState status,
    @Default('') String message,
    @Default(Seat()) Seat seat
  }) = _SeatState;
}
