import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/notification_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
@singleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
  final AntreeRepository _antreeRepository;
  final NotificationRepository _notificationRepository;

  HomeBloc(this._antreeRepository, this._notificationRepository)
      : super(HomeState()) {
    on<HomeEvent>((events, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final newState = await events.when(
          unreadNotification: _unreadNotification,
          updateNotificationToken: _updateNotificationToken,
          antreesPagination: _antreesPagination);
      emit(newState);
    });
  }

  Future<HomeState> _unreadNotification() async {
    final response = await _notificationRepository.getUnreadNotifications();
    return response.when(
      data: (data, meta) => state.copyWith(
          notificationCounter:
              meta?.pagination.total ?? state.notificationCounter,
          status: StatusState.idle),
      error: (message) =>
          state.copyWith(message: message, status: StatusState.failure),
    );
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

  Future<HomeState> _antreesPagination(int page) async {
    final response = await _antreeRepository.getCustomerAntrees(page: page);
    return response.when(
      data: (data, meta) {
        final page = meta?.pagination ?? Pagination();
        final isLastPage = page.page == page.pageCount;
        return state.copyWith(
            data: data, status: StatusState.idleList, isLastPage: isLastPage);
      },
      error: (message) =>
          state.copyWith(status: StatusState.failure, message: message),
    );
  }
}
