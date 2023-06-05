import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/notification_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AntreeRepository _antreeRepository;
  final NotificationRepository _notificationRepository;
  HomeBloc(this._antreeRepository, this._notificationRepository)
      : super(const HomeState([])) {
    on<GetAllData>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      var newState = await getResultAntree();
      newState = await getResultNotifications(newState);
      emit(newState);
    });
    on<Dispose>((event, emit) {
      logger.d('dispose');
      // _antreeRepository.cancelRequest(reason: 'Disposed');
    });
  }

  Future<HomeState> getResultAntree() async {
    final response = await _antreeRepository.getCustomerAntrees();
    return response.when(
      data: (data, meta) =>
          state.copyWith(data: data, status: StatusState.idle),
      error: (message) =>
          state.copyWith(status: StatusState.failure, message: message),
    );
  }

  Future<HomeState> getResultNotifications(HomeState newState) async {
    final response = await _notificationRepository.getUnreadNotifications();
    return response.when(
      data: (data, meta) => newState.copyWith(
          notificationCounter: meta?.pagination.total,
          status: StatusState.idle),
      error: (message) =>
          newState.copyWith(message: message, status: StatusState.failure),
    );
  }
}
