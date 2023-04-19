import 'package:antreeorder/components/antree_text.dart';
import 'package:flutter/material.dart';

import '../../res/export_res.dart';
import '../../utils/export_utils.dart';
import '../antree/antree_screen.dart';

class ItemHome extends StatelessWidget {
  final int index;
  const ItemHome({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 10,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => AppRoute.to(AntreeScreen(antrean: index)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AntreeText(
              index.toString(),
              style: AntreeTextStyle.title,
              fontSize: 40,
            ),
            const AntreeText("Merchant Name")
          ],
        ),
      ),
    );
  }
}
