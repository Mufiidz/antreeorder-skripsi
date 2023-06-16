import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/merchant_repository.dart';
import 'package:antreeorder/repository/notification_repository.dart';
import 'package:antreeorder/repository/status_antree_repository.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
@singleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AntreeRepository _antreeRepository;
  final NotificationRepository _notificationRepository;
  final MerchantRepository _merchantRepository;
  final StatusAntreeRepository _statusAntreeRepository;

  HomeBloc(this._antreeRepository, this._notificationRepository,
      this._merchantRepository, this._statusAntreeRepository)
      : super(HomeState()) {
    on<HomeEvent>((events, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final newestState = await events.when(
          getAllData: _getAllData,
          upadateStatusAntree: _upadateStatusAntree,
          updateNotificationToken: _updateNotificationToken,
          antreesPagination: _antreesPagination);
      emit(newestState);
    });
  }

  Future<HomeState> _getAllData() async {
    // Get Detail Merchant
    final merchantResponse = await _merchantRepository.detailMerchant();
    var newState = merchantResponse.when(
      data: (data, meta) => state.copyWith(merchant: data),
      error: (message) =>
          state.copyWith(status: StatusState.failure, message: message),
    );
    //Get Notification
    final notifResponse =
        await _notificationRepository.getUnreadNotifications();
    newState = notifResponse.when(
      data: (data, meta) => newState.copyWith(
          notificationCounter:
              meta?.pagination.total ?? newState.notificationCounter),
      error: (message) =>
          newState.copyWith(message: message, status: StatusState.failure),
    );

    if (newState.status == StatusState.failure) return newState;
    return newState.copyWith(status: StatusState.idle);
  }

  Future<HomeState> _upadateStatusAntree(Antree antree, bool isConfirm) async {
    final response = await _statusAntreeRepository.updateStatusAntree(antree);
    var newState = response.when(
      data: (data, meta) => state.copyWith(
          message: 'Berhasil diperbarui', status: StatusState.success),
      error: (message) =>
          state.copyWith(message: message, status: StatusState.failure),
    );
    final antreesResponse = await _antreeRepository.getMerchantAntrees();
    newState = antreesResponse.when(
      data: (data, meta) =>
          state.copyWith(status: StatusState.idle, antrees: data),
      error: (message) =>
          state.copyWith(status: StatusState.failure, message: message),
    );
    return newState;
  }

  Future<HomeState> _updateNotificationToken(String refreshedToken) async {
    final response =
        await _notificationRepository.updateTokenNotification(refreshedToken);
    final message = response.when(
      data: (data, meta) =>
          'FirebaseMessaging token updated => ${data.notificationToken}',
      error: (message) => 'FirebaseMessaging token error => $message',
    );
    logger.d(message);
    return state.copyWith(status: StatusState.idle);
  }

  Future<HomeState> _antreesPagination(int newPage) async {
    final response = await _antreeRepository.getMerchantAntrees(page: newPage);
    final newState = response.when(
      data: (data, meta) {
        final page = meta?.pagination ?? Pagination();
        final isLastPage = page.page == page.pageCount;
        return state.copyWith(
            antrees: data,
            status: StatusState.idleList,
            isLastPage: isLastPage);
      },
      error: (message) =>
          state.copyWith(status: StatusState.failure, message: message),
    );
    return newState;
  }
}
