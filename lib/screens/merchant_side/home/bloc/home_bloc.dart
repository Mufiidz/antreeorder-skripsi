import 'dart:async';

import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/merchant_repository2.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MerchantRepository2 _merchantRepository;
  final AntreeRepository _antreeRepository;
  final StreamController<List<Antree>> streamController = StreamController();
  HomeBloc(this._merchantRepository, this._antreeRepository)
      : super(const HomeState([])) {
    on<GetAntrians>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        // final response = await _merchantRepository
        //     .antrianMerchant(event.merchantId, date: 5);
        // final data = response.data;
        // logger.d(data);
        // emit(data != null
        //     ? state.copyWith(data: data, status: StatusState.idle)
        //     : state.copyWith(
        //         message: response.message,
        //         status: StatusState.failure,
        //       ));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "ERROR"));
      }
    });

    on<GetAntrians2>((event, emit) {
      Timer.periodic(const Duration(seconds: 30), (timer) async {
        logger.d('Try to getting data');
        // final response =
        //     await _merchantRepository.antrianMerchant(event.merchantId);
        // streamController.sink.add(response.data ?? []);
      });
    });

    on<UpadateStatusAntree>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response = await _antreeRepository.updateStatusAntree(
            event.antreeId, event.statusId);
        final data = response.data;
        emit(data != null
            ? state.copyWith(antree: data, status: StatusState.success)
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "ERROR"));
      }
    });
  }
}
