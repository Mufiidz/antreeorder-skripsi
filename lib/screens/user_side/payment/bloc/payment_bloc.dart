import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/transaction_status.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/payment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'payment_event.dart';
part 'payment_state.dart';
part 'payment_bloc.freezed.dart';

@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final AntreeRepository _antreeRepository;
  final PaymentRepository _paymentRepository;
  PaymentBloc(this._antreeRepository, this._paymentRepository)
      : super(PaymentState()) {
    on<PaymentEvent>((events, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final paymentState = await events.when(
        successPayment: (antree) async {
          final response =
              await _antreeRepository.addAntreeOnlinePayment(antree.id);
          final newState = response.when(
            data: (data, meta) => state.copyWith(
                status: StatusState.success, message: 'Pembayaran berhasil'),
            error: (message) =>
                state.copyWith(status: StatusState.failure, message: message),
          );
          return newState;
        },
        loadingPayment: (isLoading) async => state.copyWith(
            status: isLoading ? StatusState.loading : StatusState.idle),
        transactionStatus: (String id) async {
          final response = await _paymentRepository.paymentStatus(id);
          return response.when(
            data: (data, meta) => state.copyWith(
              transactionStatus: data,
              status: StatusState.success,
            ),
            error: (message) =>
                state.copyWith(status: StatusState.failure, message: message),
          );
        },
        expirePayment: (Antree antree) async {
          final response = await _paymentRepository.expirePayment(antree);
          return response.when(
            data: (data, meta) {
              return state.copyWith(status: StatusState.idle);
            },
            error: (message) => state.copyWith(message: message),
          );
        },
      );
      emit(paymentState);
    });
  }
}
