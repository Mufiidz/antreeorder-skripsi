import 'package:antreeorder/repository/merchant_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/base_state.dart';
import '../../../models/merchant.dart';

part 'merchant_event.dart';
part 'merchant_state.dart';

class MerchantBloc extends Bloc<MerchantEvent, MerchantState> {
  final MerchantRepository _merchantRepository;

  MerchantBloc(this._merchantRepository) : super(const MerchantState([])) {
    on<GetMerchants>((event, emit) async {
      // emit(state.copyWith(status: StatusState.loading));
      emit(state.copyWith(
          merchants: [const Merchant()], status: StatusState.success));
      // try {
      //   final response = await _merchantRepository.getMerchants();
      //   final data = response.data;
      //   emit(data != null
      //       ? state.copyWith(
      //           status: StatusState.success, merchants: data)
      //       : state.copyWith(
      //           status: StatusState.failure, errorMessage: response.message));
      // } catch (e) {
      //   emit(
      //       state.copyWith(status: StatusState.failure, errorMessage: "Error"));
      // }
    });
  }
}
