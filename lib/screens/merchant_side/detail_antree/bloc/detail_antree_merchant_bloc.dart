import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/content_detail.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/status_antree_repository.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/section/detail_antree_section.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/section/detail_pembayaran_section.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/section/detail_products_section.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'detail_antree_merchant_event.dart';
part 'detail_antree_merchant_state.dart';
part 'detail_antree_merchant_bloc.freezed.dart';

@injectable
class DetailAntreeMerchantBloc
    extends Bloc<DetailAntreeMerchantEvent, DetailAntreeMerchantState> {
  final AntreeRepository _antreeRepository;
  final StatusAntreeRepository _statusAntreeRepository;
  DetailAntreeMerchantBloc(this._statusAntreeRepository, this._antreeRepository)
      : super(DetailAntreeMerchantState()) {
    on<DetailAntreeMerchantEvent>((events, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final newState = await events.when(
        initial: (antreeId) async {
          final response = await _antreeRepository.detailAntree(antreeId);
          return response.when(
            data: (data, meta) => state.copyWith(
                status: StatusState.idle,
                antree: data,
                sections: getSections(data),
                detailAntreeButton: getDetailAntreeBtn(data)),
            error: (message) =>
                state.copyWith(message: message, status: StatusState.failure),
          );
        },
        updateStatus: (antree) async {
          final response =
              await _statusAntreeRepository.updateStatusAntree(antree);
          return response.when(
            data: (data, meta) => state.copyWith(
                antree: data,
                status: StatusState.success,
                sections: getSections(data),
                message:
                    'Berhasil memperbarui Antree menjadi "${data.status.message}"',
                detailAntreeButton: getDetailAntreeBtn(data)),
            error: (message) =>
                state.copyWith(message: message, status: StatusState.failure),
          );
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
                sections: getSections(data),
                message: 'Berhasil membatalkan Antree',
                detailAntreeButton: getDetailAntreeBtn(data)),
            error: (message) =>
                state.copyWith(message: message, status: StatusState.failure),
          );
          return newState;
        },
        // confirmAntree: (Antree antree) async {
        //   final response = await _statusAntreeRepository.confirmAntree(antree);
        //   final newState = response.when(
        //     data: (data, meta) => state.copyWith(
        //         antree: data,
        //         sections: getSections(data),
        //         status: StatusState.success,
        //         message: 'Berhasil konfirmasi Antree',
        //         detailAntreeButton: getDetailAntreeBtn(data)),
        //     error: (message) =>
        //         state.copyWith(message: message, status: StatusState.failure),
        //   );
        //   return newState;
        // },
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
            positiveActionButton: DetailAntreeBtnAction.increase,
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

  List<Widget> getSections(Antree data) => [
        DetailAntreeSection(
          detailsAntree: detailsAntree(data),
        ),
        DetailProductsSection(data.orders),
        DetailPembayaranSection(
          antree: data,
        )
      ];
}

List<ContentDetail> detailsAntree(Antree antree) {
  List<ContentDetail> detailsAntree = [
    ContentDetail(title: "Status", value: antree.status.message),
    ContentDetail(title: "Antree ID", value: antree.id.toString()),
    ContentDetail(title: "Seat", value: antree.seat.title),
    ContentDetail(
        title: "Tanggal Pembelian",
        value: antree.createdAt
                ?.toStringDate(pattern: 'EEEE, dd MMMM yyyy HH:mm') ??
            '-'),
  ];
  if (antree.takenAt != null) {
    detailsAntree.add(ContentDetail(
        title: "Tanggal Pengambilan",
        value:
            antree.takenAt?.toStringDate(pattern: 'EEEE, dd MMMM yyyy HH:mm') ??
                '-'));
  }
  return detailsAntree;
}
