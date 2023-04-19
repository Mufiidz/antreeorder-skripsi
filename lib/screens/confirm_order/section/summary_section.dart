import 'package:antreeorder/utils/int_ext.dart';
import 'package:flutter/material.dart';

import '../../../components/export_components.dart';
import '../../../models/summary.dart';
import '../../../res/export_res.dart';

class SummarySection extends StatelessWidget {
  final List<Summary> summaries;
  const SummarySection({Key? key, this.summaries = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AntreeText(
            "Ringkasan",
            style: AntreeTextStyle.medium.bold.copyWith(fontSize: 18),
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 10),
              itemCount: summaries.length,
              itemBuilder: ((context, index) {
                final summary = summaries[index];
                return Row(
                  children: [
                    Expanded(child: AntreeText(summary.title)),
                    Expanded(
                        child: AntreeText(
                      summary.price.toIdr(),
                      textAlign: TextAlign.end,
                    )),
                  ],
                );
              }))
        ],
      ),
    );
  }
}
