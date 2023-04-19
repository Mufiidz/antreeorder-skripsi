import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:antreeorder/models/base_state.dart';

import '../../../models/antree.dart';
import '../../../models/order.dart';
import '../../../models/summary.dart';

part 'confirm_order_event.dart';
part 'confirm_order_state.dart';

class ConfirmOrderBloc extends Bloc<ConfirmOrderEvent, ConfirmOrderState> {
  List<Summary> summaries = [];
  int total = 0;
  int subTotal = 0;
  ConfirmOrderBloc() : super(const ConfirmOrderState(0)) {
    on<GetInitialConfirm>((event, emit) {
      if (subTotal != 0 && summaries.isNotEmpty && total != 0) {
        subTotal = 0;
        summaries.clear();
        total = 0;
      }
      for (var order in event.orders) {
        subTotal += (order.quantity * order.price);
      }
      summaries.add(Summary(title: 'Subtotal Pesanan', price: subTotal));
      summaries.add(event.summary);
      for (var summary in summaries) {
        total += summary.price;
      }
      emit(state.copyWith(
          total: total,
          status: StatusState.success,
          summaries: summaries,
          subtotal: subTotal));
    });

    on<AddAntree>((event, emit) {
      logger.d(event.antree);
    });
  }
}
