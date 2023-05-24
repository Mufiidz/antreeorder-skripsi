import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/seat.dart';
import 'package:antreeorder/repository/seat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'seat_event.dart';
part 'seat_state.dart';
part 'seat_bloc.freezed.dart';

@injectable
class SeatBloc extends Bloc<SeatEvent, SeatState> {
  final SeatRepository _seatRepository;

  SeatBloc(this._seatRepository) : super(SeatState()) {
    on<SeatEvent>((events, emit) async {
      final finalState = await events.when(
        intial: () async => state,
        getSeats: () async {
          var newState = state.copyWith(status: StatusState.loading);
          final response = await _seatRepository.merchantSeats();
          newState = response.when(
            data: (data, meta) =>
                newState.copyWith(data: data, status: StatusState.idle),
            error: (message) => newState.copyWith(
                message: message, status: StatusState.failure),
          );
          return newState;
        },
        addSeat: (seat) async {
          var newState = state.copyWith(status: StatusState.loading);
          final response = await _seatRepository.addSeat(seat);
          newState = response.when(
            data: (data, meta) => newState.copyWith(
                seat: data,
                status: StatusState.success,
                message: 'Berhasil menambahkan ${data.title}'),
            error: (message) => newState.copyWith(
                message: message, status: StatusState.failure),
          );
          return newState;
        },
        deleteSeat: (seatId) async {
          var newState = state.copyWith(status: StatusState.loading);
          final response = await _seatRepository.deleteSeat(seatId);
          newState = response.when(
            data: (data, meta) => newState.copyWith(
                seat: data,
                status: StatusState.success,
                message: 'Berhasil menghapus ${data.title}'),
            error: (message) => newState.copyWith(
                message: message, status: StatusState.failure),
          );
          return newState;
        },
      );
      emit(finalState);
    });
  }
}
