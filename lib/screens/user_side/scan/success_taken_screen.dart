import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/content_detail.dart';
import 'package:antreeorder/res/antree_textstyle.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/section/detail_antree_section.dart';
import 'package:antreeorder/screens/user_side/home/home_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

class SuccessTakenScreen extends StatelessWidget {
  final Antree antree;
  const SuccessTakenScreen({Key? key, this.antree = const Antree()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppRoute.clearAll(HomeScreen());
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AntreeText(
                        'Pesanan berhasil\ndiambil',
                        style: AntreeTextStyle.title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DetailAntreeSection(detailsAntree: detailsAntree(antree)),
                  ],
                )),
            Container(
              width: context.mediaSize.width,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      offset: Offset(0, -2))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: AntreeButton(
                  "Home",
                  onClick: () => AppRoute.clearAll(HomeScreen()),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
}
