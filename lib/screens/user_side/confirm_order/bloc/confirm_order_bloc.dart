import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/models/summary.dart';
import 'package:antreeorder/repository/antree_repository2.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:antreeorder/models/base_state2.dart';

part 'confirm_order_event.dart';
part 'confirm_order_state.dart';

class ConfirmOrderBloc extends Bloc<ConfirmOrderEvent, ConfirmOrderState> {
  final List<Summary> _summaries = [];
  int _total = 0;
  int _subTotal = 0;
  final AntreeRepository2 _antreeRepository;
  ConfirmOrderBloc(this._antreeRepository) : super(const ConfirmOrderState(0)) {
    on<GetInitialConfirm>((event, emit) {
      if (_subTotal != 0 || _summaries.isNotEmpty || _total != 0) {
        _subTotal = 0;
        _summaries.clear();
        _total = 0;
      }
      for (var order in event.orders) {
        _subTotal += (order.quantity * order.price);
      }
      _summaries.add(Summary(title: 'Subtotal Pesanan', price: _subTotal));
      _summaries.add(event.summary);
      for (var summary in _summaries) {
        _total += summary.price;
      }
      emit(state.copyWith(
          total: _total,
          status: StatusState.idle,
          summaries: _summaries,
          subtotal: _subTotal));
    });

    on<AddAntree>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      logger.d(event.antree);
      try {
        final response = await _antreeRepository.add(event.antree);
        final data = response.data;
        emit(data != null
            ? state.copyWith(status: StatusState.success, message: "Success")
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        state.copyWith(status: StatusState.failure, message: 'Error');
      }
    });
  }
}
