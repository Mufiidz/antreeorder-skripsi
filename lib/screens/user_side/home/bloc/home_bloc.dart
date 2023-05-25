import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
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
      final response = await _antreeRepository.getCustomerAntrees();
      final newState = response.when(
        data: (data, meta) =>
            state.copyWith(data: data, status: StatusState.idle),
        error: (message) =>
            state.copyWith(status: StatusState.failure, message: message),
      );
      emit(newState);
    });
    on<Dispose>((event, emit) {
      logger.d('dispose');
      // _antreeRepository.cancelRequest(reason: 'Disposed');
    });
  }
}
