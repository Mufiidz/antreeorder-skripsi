import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AntreeRepository _antreeRepository;
  HomeBloc(this._antreeRepository) : super(const HomeState([])) {
    on<GetAntrians>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response = await _antreeRepository.listAntree(event.userId);
        final data = response.data;
        emit(data != null
            ? state.copyWith(status: StatusState.idle, data: data)
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "Error"));
      }
    });
    on<Dispose>((event, emit) {
      logger.d('dispose');
      _antreeRepository.cancelRequest(reason: 'Disposed');
    });
  }
}
