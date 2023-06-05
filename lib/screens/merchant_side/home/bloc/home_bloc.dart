import 'dart:async';

import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/notification_repository.dart';
import 'package:antreeorder/repository/status_antree_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AntreeRepository _antreeRepository;
  final NotificationRepository _notificationRepository;
  // final StreamController<List<Antree>> streamController = StreamController();
  final StatusAntreeRepository _statusAntreeRepository;
  HomeBloc(this._antreeRepository, this._statusAntreeRepository,
      this._notificationRepository)
      : super(const HomeState([])) {
    on<GetAllData>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final response = await _antreeRepository.getMerchantAntrees();
      final notifResponse =
          await _notificationRepository.getUnreadNotifications();
      var newState = response.when(
        data: (data, meta) =>
            state.copyWith(status: StatusState.idle, data: data),
        error: (message) =>
            state.copyWith(status: StatusState.failure, message: message),
      );
      newState = notifResponse.when(
        data: (data, meta) => newState.copyWith(
            notificationCounter: meta?.pagination.total,
            status: StatusState.idle),
        error: (message) =>
            newState.copyWith(message: message, status: StatusState.failure),
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
      final updateResponse =
          await _statusAntreeRepository.updateStatusAntree(event.antree);
      HomeState newState = updateResponse.when(
        data: (data, meta) => state.copyWith(
            message: 'Berhasil diperbarui', status: StatusState.success),
        error: (message) =>
            state.copyWith(message: message, status: StatusState.failure),
      );
      final response = await _antreeRepository.getMerchantAntrees();
      newState = response.when(
        data: (data, meta) =>
            state.copyWith(status: StatusState.idle, data: data),
        error: (message) =>
            state.copyWith(status: StatusState.failure, message: message),
      );
      emit(newState);
    });
  }
}
