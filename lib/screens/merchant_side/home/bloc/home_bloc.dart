import 'dart:async';

import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/antree_repository2.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AntreeRepository2 _antreeRepository2;
  final AntreeRepository _antreeRepository;
  final StreamController<List<Antree>> streamController = StreamController();
  HomeBloc(this._antreeRepository, this._antreeRepository2)
      : super(const HomeState([])) {
    on<GetAntrians>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final response = await _antreeRepository.getMerchantAntrees();
      final newState = response.when(
        data: (data, meta) =>
            state.copyWith(status: StatusState.idle, data: data),
        error: (message) =>
            state.copyWith(status: StatusState.failure, message: message),
      );
      emit(newState);
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
        final response = await _antreeRepository2.updateStatusAntree(
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
