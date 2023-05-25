import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/summary.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/screens/user_side/confirm_order/section/summary_section.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

class DetailPembayaranSection extends StatelessWidget {
  final List<Summary> summaries;
  final int total;
  const DetailPembayaranSection({Key? key, required this.summaries, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummarySection(summaries: summaries),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: AntreeColors.separator),
                    bottom: BorderSide(color: AntreeColors.separator))),
            child: Row(
              children: [
                Expanded(
                    child: AntreeText(
                  'Total',
                  style: AntreeTextStyle.medium,
                )),
                Expanded(
                    child: AntreeText(
                  total.toIdr(),
                  textAlign: TextAlign.end,
                  style: AntreeTextStyle.medium,
                )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
