import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/content_detail.dart';
import 'package:antreeorder/models/summary.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/section/detail_antree_section.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/section/detail_pembayaran_section.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/section/detail_products_section.dart';
import 'package:antreeorder/screens/user_side/antree/section/antree_section.dart';
import 'package:antreeorder/utils/datetime_ext.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'antree_event.dart';
part 'antree_state.dart';
part 'antree_bloc.freezed.dart';

@injectable
@singleton
class AntreeBloc extends Bloc<AntreeEvent, AntreeState> {
  final AntreeRepository _antreeRepository;
  AntreeBloc(this._antreeRepository) : super(const AntreeState()) {
    on<AntreeEvent>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final newState = await event.when(initial: (antreeId) async {
        final response = await _antreeRepository.detailAntree(antreeId);
        return response.when(
          data: (data, meta) => state.copyWith(
              status: StatusState.idle,
              antree: data,
              sections: listSection(data)),
          error: (message) =>
              state.copyWith(message: message, status: StatusState.failure),
        );
      });
      emit(newState);
    });
  }

  List<Widget> listSection(Antree antree) {
    var listSection = [
      DetailAntreeSection(detailsAntree: detailsAntree(antree)),
      DetailProductsSection(antree.orders),
      DetailPembayaranSection(
        antree: antree,
      )
    ];
    if (antree.status.id < 5) {
      listSection.insert(
          0,
          AntreeSection(
              antreeNumber: antree.antreeNum, remaining: antree.remaining));
      listSection = listSection;
    }
    return listSection;
  }

  List<ContentDetail> detailsAntree(Antree antree) {
    List<ContentDetail> detailsAntree = [
      ContentDetail(title: "Status", value: antree.status.message),
      ContentDetail(title: "Antree ID", value: antree.id.toString()),
      ContentDetail(
          title: "Tanggal Pembelian",
          value: antree.createdAt
                  ?.toStringDate(pattern: 'EEEE, dd MMMM yyyy HH:mm') ??
              '-'),
    ];
    if (antree.takenAt != null) {
      detailsAntree.add(ContentDetail(
          title: "Tanggal Pengambilan",
          value: antree.takenAt
                  ?.toStringDate(pattern: 'EEEE, dd MMMM yyyy HH:mm') ??
              '-'));
    }
    return detailsAntree;
  }

  List<Summary> summaries(Antree antree) => [
        Summary(title: 'Subtotal pesanan', price: subTotal(antree)),
        Summary(title: 'Biaya layanan', price: 1000)
      ];

  int subTotal(Antree antree) => antree.orders.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.quantity * element.price));
}
