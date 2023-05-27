import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/detail_antree_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

import 'home_orders_section.dart';

typedef OnSwipeChange = void Function(int);

class ItemHome extends StatelessWidget {
  final Antree antree;
  final OnSwipeChange onSwipeChange;
  const ItemHome(this.antree, this.onSwipeChange, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(antree.id.toString()),
      background: Container(
        color: Colors.green,
      ),
      secondaryBackground: Container(
        color: Colors.red,
      ),
      confirmDismiss: (direction) async {
        final statusId = antree.status.id;
        if (statusId == 7 || statusId == 6 || statusId == 4 || statusId == 5) {
          onSwipeChange(statusId);
          return false;
        }
        if (direction == DismissDirection.startToEnd) {
          onSwipeChange(antree.status.id + 1);
          return false;
        }
        if (direction == DismissDirection.endToStart) {
          onSwipeChange(antree.status.id - 1);
          return false;
        }
        return null;
      },
      child: SizedBox(
        width: context.mediaSize.width,
        child: InkWell(
          onTap: () => AppRoute.to(DetailAntreeScreen(
            antree: antree,
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 10,
              child: AntreeList<Widget>(
                _section,
                isSeparated: true,
                shrinkWrap: true,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, item, index) => item,
                separatorBuilder: (context, item, index) => const Divider(
                  color: AntreeColors.separator,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get _section => [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Row(
            children: [
              Expanded(
                  child: RichText(
                      text: TextSpan(children: [
                const TextSpan(
                    text: 'No. Antree : ', style: AntreeTextStyle.normal),
                TextSpan(
                    text: antree.antreeNum != null
                        ? antree.antreeNum.toString()
                        : '-',
                    style: AntreeTextStyle.bold.copyWith(fontSize: 16)),
              ]))),
              Expanded(
                  child: AntreeText(
                antree.status.message,
                textAlign: TextAlign.end,
              )),
            ],
          ),
        ),
        HomeOrdersSection(antree.orders)
      ];
}
