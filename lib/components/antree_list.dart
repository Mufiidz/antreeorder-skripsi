import 'package:flutter/material.dart';

typedef OnItemBuilder<Item> = Widget Function(
    BuildContext context, Item item, int index);

class AntreeList<T> extends StatelessWidget {
  final bool isSeparated;
  final List<T> list;
  final OnItemBuilder<T> itemBuilder;
  final OnItemBuilder<T>? separatorBuilder;
  final bool shrinkWrap;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  const AntreeList(this.list,
      {super.key,
      required this.itemBuilder,
      this.isSeparated = false,
      this.separatorBuilder,
      this.shrinkWrap = false,
      this.scrollPhysics,
      this.controller,
      this.padding,
      this.scrollDirection = Axis.vertical});

  @override
  Widget build(BuildContext context) {
    return !isSeparated
        ? ListView.builder(
            scrollDirection: scrollDirection,
            padding: padding,
            shrinkWrap: shrinkWrap,
            physics: scrollPhysics,
            controller: controller,
            itemBuilder: (context, index) =>
                itemBuilder(context, list[index], index),
            itemCount: list.length,
          )
        : ListView.separated(
            padding: padding,
            scrollDirection: scrollDirection,
            shrinkWrap: shrinkWrap,
            physics: scrollPhysics,
            controller: controller,
            itemBuilder: (context, index) =>
                itemBuilder(context, list[index], index),
            separatorBuilder: (context, index) => separatorBuilder != null
                ? separatorBuilder!(context, list[index], index)
                : const Divider(),
            itemCount: list.length);
  }
}
