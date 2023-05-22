import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/repository/merchant_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'merchant_event.dart';
part 'merchant_state.dart';

class MerchantBloc extends Bloc<MerchantEvent, MerchantState> {
  final MerchantRepository _merchantRepository;

  MerchantBloc(this._merchantRepository) : super(const MerchantState([])) {
    on<GetMerchants>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response = await _merchantRepository.getMerchants();
        final data = response.data;
        emit(data != null
            ? state.copyWith(status: StatusState.idle, merchants: data)
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "Error"));
      }
    });
  }
}
