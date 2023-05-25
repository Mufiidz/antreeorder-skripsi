import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/content_detail.dart';
import 'package:antreeorder/models/summary.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/section/detail_antree_section.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/section/detail_pembayaran_section.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/section/detail_products_section.dart';
import 'package:antreeorder/screens/user_side/antree/section/antree_section.dart';
import 'package:antreeorder/utils/datetime_ext.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'antree_event.dart';
part 'antree_state.dart';
part 'antree_bloc.freezed.dart';

class AntreeBloc extends Bloc<AntreeEvent, AntreeState> {
  AntreeBloc() : super(const AntreeState()) {
    on<AntreeEvent>((event, emit) {
      event.when(initial: (antree) {
        List<Widget> listSection = [
          DetailAntreeSection(detailsAntree(antree)),
          DetailProductsSection(antree.orders),
          DetailPembayaranSection(
              summaries: summaries(antree), total: antree.totalPrice)
        ];
        if (antree.status.id < 5) {
          listSection.insert(
              0,
              AntreeSection(
                  antreeNumber: antree.antreeNum, remaining: antree.remaining));
          listSection = listSection;
        }
        emit(state.copyWith(sections: listSection));
      });
    });
  }

  List<ContentDetail> detailsAntree(Antree antree) => [
        ContentDetail(title: "Status", value: antree.status.message),
        ContentDetail(title: "Antree ID", value: antree.id.toString()),
        ContentDetail(
            title: "Tanggal Pembelian",
            value: antree.createdAt
                    ?.toStringDate(pattern: 'EEEE, dd MMMM yyyy HH:mm') ??
                '-'),
      ];

  List<Summary> summaries(Antree antree) => [
        Summary(title: 'Subtotal pesanan', price: subTotal(antree)),
        Summary(title: 'Biaya layanan', price: 1000)
      ];

  int subTotal(Antree antree) => antree.orders.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.quantity * element.price));
}
