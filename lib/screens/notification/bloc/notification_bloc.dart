import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/notification.dart';
import 'package:antreeorder/models/page.dart';
import 'package:antreeorder/repository/notification_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notification_event.dart';
part 'notification_state.dart';
part 'notification_bloc.freezed.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository;
  NotificationBloc(this._notificationRepository) : super(NotificationState()) {
    on<NotificationEvent>((events, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final newState = await events.when(
        getNotifications: (page) => getNotifications(page),
        readNotifications: (notification) => readNotification(notification),
      );
      emit(newState);
    });
  }

  Future<NotificationState> getNotifications(int newPage) async {
    final response =
        await _notificationRepository.getNotifications(page: newPage);
    return response.when(
      data: (data, meta) {
        final page = meta?.pagination ?? Pagination();
        final isLastPage = page.page == page.pageCount;
        return state.copyWith(
            notifications: data,
            page: meta?.pagination.toPage ?? state.page,
            isLastPage: isLastPage,
            status: StatusState.idle);
      },
      error: (message) =>
          state.copyWith(message: message, status: StatusState.failure),
    );
  }

  Future<NotificationState> readNotification(Notification notification) async {
    final response =
        await _notificationRepository.updateReadNotif(notification.id);
    return response.when(
      data: (data, meta) => state.copyWith(
        status: StatusState.success,
      ),
      error: (message) =>
          state.copyWith(status: StatusState.failure, message: message),
    );
  }
}
