import 'package:flutter/material.dart';

import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/res/export_res.dart';

class AntreeSection extends StatelessWidget {
  final int? antreeNumber;
  final int? remaining;
  const AntreeSection({
    Key? key,
    this.antreeNumber,
    this.remaining,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 30, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AntreeText("Your Antree"),
              const AntreeSpacer(
                size: 30,
              ),
              AntreeText(
                '${antreeNumber ?? '-'}',
                style: AntreeTextStyle.title,
                fontSize: 70,
              ),
              const AntreeSpacer(
                size: 30,
              ),
              AntreeText(
                "Please wait until ${remaining ?? '-'} more people again to reach your order. Thank you.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 5,
          color: AntreeColors.separator,
        )
      ],
    );
  }
}
