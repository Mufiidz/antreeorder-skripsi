import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/content_detail.dart';
import 'package:antreeorder/models/summary.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/utils/datetime_ext.dart';
import 'package:flutter/material.dart';

import 'section/detail_antree_section.dart';
import 'section/detail_pembayaran_section.dart';
import 'section/detail_products_section.dart';

class DetailAntreeScreen extends StatelessWidget {
  final Antree antree;
  const DetailAntreeScreen({Key? key, required this.antree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AntreeAppBar('Detail Antree'),
      body: AntreeList<Widget>(_section,
          isSeparated: true,
          itemBuilder: (context, item, index) => item,
          separatorBuilder: (context, item, index) => const Divider(
                thickness: 5,
                color: AntreeColors.separator,
              )),
    );
  }

  List<Widget> get _section => [
        DetailAntreeSection(detailsAntree),
        DetailProductsSection(antree.orders),
        DetailPembayaranSection(summaries: summaries, total: antree.totalPrice)
      ];

  List<ContentDetail> get detailsAntree => [
        ContentDetail(title: "Status", value: antree.status.message),
        ContentDetail(title: "Antree ID", value: antree.id.toString()),
        ContentDetail(
            title: "Tanggal Pembelian",
            value: antree.createdAt
                    ?.toStringDate(pattern: 'EEEE, dd MMMM yyyy HH:mm') ??
                '-'),
      ];

  List<Summary> get summaries => [
        Summary(title: 'Subtotal pesanan', price: subTotal),
        Summary(title: 'Biaya layanan', price: 1000)
      ];

  int get subTotal => antree.orders
      .fold(0, (previousValue, element) => previousValue + element.price);
}
