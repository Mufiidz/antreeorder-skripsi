import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'payment_event.dart';
part 'payment_state.dart';
part 'payment_bloc.freezed.dart';

@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final AntreeRepository _antreeRepository;
  PaymentBloc(this._antreeRepository) : super(PaymentState()) {
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
      );
      emit(paymentState);
    });
  }
}
