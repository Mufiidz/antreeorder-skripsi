import 'package:antreeorder/components/export_components.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef OnItemBuilder<T> = Widget Function(
    BuildContext context, T item, int index);

enum ListType { normal, separated, paging, pagingSeparated }

/// To include paging, use [AntreeList.paging].
class AntreeList<T> extends BaseList<T> {
  final bool isSeparated;
  final OnItemBuilder<T> itemBuilder;
  AntreeList(
    List<T> list, {
    this.isSeparated = false,
    super.padding,
    required this.itemBuilder,
    super.separatorBuilder,
    super.shrinkWrap = false,
    super.scrollPhysics,
    super.controller,
    super.scrollDirection = Axis.vertical,
  }) : super(
            list: list,
            itemBuilder: itemBuilder,
            type: isSeparated ? ListType.separated : ListType.normal);
  AntreeList.paging(
    PagingController<int, T> pagingContrroller, {
    required this.itemBuilder,
    this.isSeparated = false,
    super.separatorBuilder,
    super.shrinkWrap = false,
    super.scrollPhysics,
    super.controller,
    super.scrollDirection = Axis.vertical,
  }) : super(
            itemBuilder: itemBuilder,
            pagingController: pagingContrroller,
            type: isSeparated ? ListType.pagingSeparated : ListType.paging);
}

class BaseList<T> extends StatelessWidget {
  final List<T> list;
  final OnItemBuilder<T> itemBuilder;
  final OnItemBuilder<T>? separatorBuilder;
  final bool shrinkWrap;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final ListType type;
  final PagingController<int, T>? pagingController;
  // AntreeList(this.list,
  //     {super.key,
  //     required this.itemBuilder,
  //     this.separatorBuilder,
  //     required this.shrinkWrap,
  //     this.scrollPhysics,
  //     this.controller,
  //     this.padding,
  //     required this.scrollDirection,
  //     required this.type});

  // AntreeList.paging(PagingController<int, T> pagingController,
  //     {super.key,
  //     required this.itemBuilder,
  //     this.separatorBuilder,
  //     required this.shrinkWrap,
  //     this.scrollPhysics,
  //     this.controller,
  //     this.padding,
  //     required this.scrollDirection,
  //     required this.type});
  const BaseList(
      {super.key,
      required this.itemBuilder,
      this.type = ListType.normal,
      this.separatorBuilder,
      this.shrinkWrap = false,
      this.scrollPhysics,
      this.controller,
      this.padding,
      this.scrollDirection = Axis.vertical,
      this.list = const [],
      this.pagingController});

  @override
  Widget build(BuildContext context) {
    if (type == ListType.separated) return separatedList;
    if (type == ListType.paging) return pagingList;
    if (type == ListType.pagingSeparated) return pagingListSeparated;
    return normalList;
  }

  Widget get normalList => ListView.builder(
        scrollDirection: scrollDirection,
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: scrollPhysics,
        controller: controller,
        itemBuilder: (context, index) =>
            itemBuilder(context, list[index], index),
        itemCount: list.length,
      );

  Widget get separatedList => ListView.separated(
      padding: padding,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: scrollPhysics,
      controller: controller,
      itemBuilder: (context, index) => itemBuilder(context, list[index], index),
      separatorBuilder: (context, index) => separatorBuilder != null
          ? separatorBuilder!(context, list[index], index)
          : const Divider(),
      itemCount: list.length);

  Widget get pagingList => PagedListView(
        pagingController:
            pagingController ?? PagingController<int, T>(firstPageKey: 1),
        padding: padding ?? const EdgeInsets.only(top: 8, bottom: 16),
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        physics: scrollPhysics,
        builderDelegate: builderDelegate,
      );
  Widget get pagingListSeparated => PagedListView.separated(
        pagingController:
            pagingController ?? PagingController<int, T>(firstPageKey: 1),
        padding: padding ?? const EdgeInsets.only(top: 8, bottom: 16),
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        physics: scrollPhysics,
        builderDelegate: builderDelegate,
        separatorBuilder: (BuildContext context, int index) =>
            separatorBuilder != null
                ? separatorBuilder!(
                    context, (pagingController?.itemList ?? [])[index], index)
                : const Divider(),
      );

  PagedChildBuilderDelegate<T> get builderDelegate => PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) =>
            itemBuilder(context, item, index),
        newPageProgressIndicatorBuilder: (context) => const AntreeLoading(),
        firstPageProgressIndicatorBuilder: (context) => const AntreeLoading(),
        firstPageErrorIndicatorBuilder: (context) => Center(
          child: AntreeText(pagingController?.error.toString() ?? 'ERROR'),
        ),
        noItemsFoundIndicatorBuilder: (context) => const Center(
          child: AntreeText('Empty data'),
        ),
      );
}
