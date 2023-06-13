import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/summary.dart';
import 'package:antreeorder/utils/int_ext.dart';
import 'package:flutter/material.dart';

class SummarySection extends StatelessWidget {
  final List<Summary> summaries;
  const SummarySection({Key? key, this.summaries = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
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
          })),
    );
  }
}
