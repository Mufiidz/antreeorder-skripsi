import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/detail_antree_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

typedef OnSwipeChange = void Function(int);

class ItemHome extends StatelessWidget {
  final Antree antree;
  final OnSwipeChange? onSwipeChange;
  const ItemHome(this.antree, {Key? key, this.onSwipeChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(antree.id),
      background: Container(
        color: Colors.green,
      ),
      secondaryBackground: Container(
        color: Colors.red,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onSwipeChange!(antree.status.id + 1);
          // context.snackbar.showSnackBar(SnackBar(
          //   content: Text(direction.toString()),
          //   backgroundColor: Colors.green,
          // ));
        } else {
          onSwipeChange!(antree.status.id - 1);
          // context.snackbar.showSnackBar(SnackBar(
          //   content: Text(direction.toString()),
          //   backgroundColor: Colors.red,
          // ));
        }
        return false;
      },
      child: SizedBox(
        width: context.mediaSize.width,
        child: InkWell(
          onTap: () => AppRoute.to(DetailAntreeScreen(
            antree: antree,
          )),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [AntreeText('Order id ${antree.id}')],
            ),
          ),
        ),
      ),
    );
  }
}
