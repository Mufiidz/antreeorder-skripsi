import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/repository/status_antree_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'detail_antree_merchant_event.dart';
part 'detail_antree_merchant_state.dart';
part 'detail_antree_merchant_bloc.freezed.dart';

@injectable
class DetailAntreeMerchantBloc
    extends Bloc<DetailAntreeMerchantEvent, DetailAntreeMerchantState> {
  final StatusAntreeRepository _statusAntreeRepository;
  DetailAntreeMerchantBloc(this._statusAntreeRepository)
      : super(DetailAntreeMerchantState()) {
    on<DetailAntreeMerchantEvent>((events, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final newState = await events.when(
        initial: (antree) async => state.copyWith(
            status: StatusState.idle,
            antree: antree,
            detailAntreeButton: getDetailAntreeBtn(antree)),
        updateStatus: (antree) async {
          final response =
              await _statusAntreeRepository.updateStatusAntree(antree);
          final newState = response.when(
            data: (data, meta) => state.copyWith(
                antree: data,
                status: StatusState.success,
                message:
                    'Berhasil memperbarui Antree menjadi "${data.status.message}"',
                detailAntreeButton: getDetailAntreeBtn(data)),
            error: (message) =>
                state.copyWith(message: message, status: StatusState.failure),
          );
          return newState;
        },
        cancelAntree: (Antree antree) async {
          final status = antree.status;
          antree = antree.copyWith(status: status.copyWith(id: 7));
          final response =
              await _statusAntreeRepository.updateStatusAntree(antree);
          final newState = response.when(
            data: (data, meta) => state.copyWith(
                antree: data,
                status: StatusState.success,
                message: 'Berhasil membatalkan Antree',
                detailAntreeButton: getDetailAntreeBtn(data)),
            error: (message) =>
                state.copyWith(message: message, status: StatusState.failure),
          );
          return newState;
        },
        confirmAntree: (Antree antree) async {
          final response = await _statusAntreeRepository.confirmAntree(antree);
          final newState = response.when(
            data: (data, meta) => state.copyWith(
                antree: data,
                status: StatusState.success,
                message: 'Berhasil konfirmasi Antree',
                detailAntreeButton: getDetailAntreeBtn(data)),
            error: (message) =>
                state.copyWith(message: message, status: StatusState.failure),
          );
          return newState;
        },
      );
      emit(newState);
    });
  }

  DetailAntreeButton? getDetailAntreeBtn(Antree antree) =>
      listDetailAntreeButton
          .singleWhereOrNull((element) => antree.status.id == element.statusId);

  List<DetailAntreeButton> get listDetailAntreeButton => [
        DetailAntreeButton(
            statusId: 1,
            positiveButtonText: 'Konfirmasi',
            negativeButtonText: 'Batalkan',
            positiveActionButton: DetailAntreeBtnAction.confirm,
            negativeActionButton: DetailAntreeBtnAction.cancel),
        DetailAntreeButton(
            statusId: 2,
            positiveButtonText: 'Naikkan Status',
            negativeButtonText: 'Turunkan Status',
            positiveActionButton: DetailAntreeBtnAction.increase,
            negativeActionButton: DetailAntreeBtnAction.decrease),
        DetailAntreeButton(
            statusId: 3,
            positiveButtonText: 'Naikkan Status',
            negativeButtonText: 'Turunkan Status',
            positiveActionButton: DetailAntreeBtnAction.increase,
            negativeActionButton: DetailAntreeBtnAction.decrease),
        DetailAntreeButton(
            statusId: 4,
            positiveButtonText: 'Ambil',
            negativeButtonText: 'Alihkan',
            positiveActionButton: DetailAntreeBtnAction.diambil,
            negativeActionButton: DetailAntreeBtnAction.alihkan),
        DetailAntreeButton(
            statusId: 5,
            positiveButtonText: 'Ambil',
            negativeButtonText: 'Batalkan',
            positiveActionButton: DetailAntreeBtnAction.diambil,
            negativeActionButton: DetailAntreeBtnAction.cancel),
      ];
}
