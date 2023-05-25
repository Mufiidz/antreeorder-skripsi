import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/models/seat.dart';
import 'package:antreeorder/models/summary.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/seat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:antreeorder/models/base_state2.dart';

part 'confirm_order_event.dart';
part 'confirm_order_state.dart';

class ConfirmOrderBloc extends Bloc<ConfirmOrderEvent, ConfirmOrderState> {
  final List<Summary> _summaries = [];
  int _total = 0;
  int _subTotal = 0;
  final AntreeRepository _antreeRepository;
  final SeatRepository _seatRepository;
  ConfirmOrderBloc(this._antreeRepository, this._seatRepository)
      : super(const ConfirmOrderState(0)) {
    on<GetInitialConfirm>((event, emit) async {
      if (_subTotal != 0 || _summaries.isNotEmpty || _total != 0) {
        _subTotal = 0;
        _summaries.clear();
        _total = 0;
      }
      for (var order in event.orders) {
        _subTotal += (order.quantity * order.price);
      }
      _summaries.add(Summary(title: 'Subtotal Pesanan', price: _subTotal));
      _summaries.add(Summary(title: 'Biaya Layanan', price: 1000));
      for (var summary in _summaries) {
        _total += summary.price;
      }
      final response =
          await _seatRepository.merchantSeats(merchantId: event.merchantId);
      var newState = response.when(
        data: (data, meta) {
          data = data.isNotEmpty
              ? data
              : [
                  Seat(
                      title: 'Take away',
                      description: 'Untuk yang ingin dibawa pulang',
                      quantity: 1,
                      capacity: 0)
                ];
          return state.copyWith(seats: data, seat: data.first);
        },
        error: (message) => state.copyWith(message: message),
      );
      newState = newState.copyWith(
          total: _total,
          status: StatusState.idle,
          summaries: _summaries,
          subtotal: _subTotal);

      emit(newState);
    });

    on<SelectedSeat>((event, emit) => emit(state.copyWith(seat: event.seat)));

    on<AddAntree>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final response =
          await _antreeRepository.addAntree(event.antree, event.merchantId);
      final newState = response.when(
        data: (data, meta) => state.copyWith(
            status: StatusState.success,
            message: "Berhasil menambahkan antree"),
        error: (message) =>
            state.copyWith(message: message, status: StatusState.failure),
      );
      emit(newState);
    });
  }
}
