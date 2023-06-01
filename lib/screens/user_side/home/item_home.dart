import 'package:antreeorder/components/antree_text.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/screens/user_side/antree/antree_screen.dart';
import 'package:antreeorder/screens/user_side/scan/scan_verify_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

class ItemHome extends StatelessWidget {
  final Antree antree;
  const ItemHome(this.antree, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 10,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          final status = antree.status;
          if (status.id == 4) {
            AppRoute.to(ScanVerifyScreen(antree));
          }
          AppRoute.to(AntreeScreen(antree));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AntreeText(antree.status.message),
            AntreeText(
              antree.remaining == null ? '-' : antree.remaining.toString(),
              style: AntreeTextStyle.title,
              fontSize: 40,
            ),
            AntreeText(antree.merchant.user.name)
          ],
        ),
      ),
    );
  }
}
