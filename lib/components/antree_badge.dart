import 'package:flutter/material.dart';

class AntreeBadge extends StatelessWidget {
  final int counter;
  final Function()? onClick;
  final IconData icon;
  const AntreeBadge(this.counter, {Key? key, this.onClick, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      customBorder: const CircleBorder(),
      child: Badge(
          isLabelVisible: counter != 0,
          label: Text(counter.toString()),
          child: Icon(icon)),
    );
  }
}
