part of 'seat_bloc.dart';

@freezed
class SeatEvent with _$SeatEvent {
  const factory SeatEvent.intial() = InitialSeat;
  const factory SeatEvent.getSeats() = GetSeats;
  const factory SeatEvent.addSeat(Seat seat) = AddSeat;
  const factory SeatEvent.deleteSeat(int seatId) = DeleteSeat;
}
