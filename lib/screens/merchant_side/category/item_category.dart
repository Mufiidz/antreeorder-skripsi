import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

class ItemCategory extends StatelessWidget {
  final String category;
  final void Function() onSwipeDelete;
  const ItemCategory(this.category, {Key? key, required this.onSwipeDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        secondaryBackground: Container(
          color: Colors.white,
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            if (category.contain("no category", ignoreCase: true)) {
              return false;
            } else {
              onSwipeDelete();
              return true;
            }
          }
          return false;
        },
        child: SizedBox(
          width: context.mediaSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(category),
          ),
        ));
  }
}
