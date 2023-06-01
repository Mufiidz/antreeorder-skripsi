import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/res/antree_textstyle.dart';
import 'package:antreeorder/utils/app_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:ai_barcode/ai_barcode.dart';

class VerifyScreen extends StatelessWidget {
  final Antree antree;
  const VerifyScreen({Key? key, required this.antree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AntreeAppBar(''),
      body: Container(
        width: context.mediaSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AntreeText('Verify Antree', style: AntreeTextStyle.medium.bold,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox.square(
                dimension: context.mediaSize.width / 2,
                child: PlatformAiBarcodeCreatorWidget(
                  creatorController: CreatorController(),
                  initialValue: 'AntreeOrder${antree.id}',
                ),
              ),
            ),
            AntreeText('Scan Here, to verify your order.'),
          ],
        ),
      ),
    );
  }
}
