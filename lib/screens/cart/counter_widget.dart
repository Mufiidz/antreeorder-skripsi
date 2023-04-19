import 'package:antreeorder/components/export_components.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int value;
  final VoidCallback onDeleteItem;
  final VoidCallback onAddQuantity;
  final VoidCallback onReduceQuantity;
  const CounterWidget(
      {Key? key,
      required this.value,
      required this.onDeleteItem,
      required this.onAddQuantity,
      required this.onReduceQuantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 25,
          child: ElevatedButton(
            onPressed: value <= 1 ? onDeleteItem : onReduceQuantity,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, shape: const CircleBorder()),
            child: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        AntreeText(
          value.toString(),
          fontSize: 18,
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          height: 25,
          child: ElevatedButton(
            onPressed: value >= 999 ? null : onAddQuantity,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, shape: const CircleBorder()),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
