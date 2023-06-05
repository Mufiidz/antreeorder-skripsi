import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/notification.dart' as notify;
import 'package:antreeorder/screens/notification/item_notification.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'bloc/notification_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationBloc _notificationBloc;
  final PagingController<int, notify.Notification> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _notificationBloc = getIt<NotificationBloc>();
    _pagingController.addPageRequestListener((pageKey) => _notificationBloc
        .add(NotificationEvent.getNotifications(page: pageKey)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AntreeAppBar('Notification'),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        bloc: _notificationBloc,
        listener: (context, state) {
          if (state.status == StatusState.failure) {
            context.snackbar.showSnackBar(AntreeSnackbar(
              state.message,
              status: SnackbarStatus.error,
            ));
          }
          if (state.status == StatusState.idle) {
            if (state.isLastPage) {
              _pagingController.appendLastPage(state.notifications);
            } else {
              _pagingController.appendPage(
                  state.notifications, _pagingController.nextPageKey);
            }
          }
        },
        builder: (context, state) => RefreshIndicator.adaptive(
          onRefresh: () async => _pagingController.refresh(),
          child: PagedListView<int, notify.Notification>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, index) => ItemNotification(
                  notification: item,
                  onReaded: () => _notificationBloc
                      .add(NotificationEvent.readNotifications(item)),
                  onClickDefault: () => _pagingController.refresh(),
                ),
                firstPageProgressIndicatorBuilder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
                newPageProgressIndicatorBuilder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
                newPageErrorIndicatorBuilder: (context) => Center(
                  child: Text(_pagingController.error.toString()),
                ),
                firstPageErrorIndicatorBuilder: (context) => Center(
                  child: Text(_pagingController.error.toString()),
                ),
                noItemsFoundIndicatorBuilder: (context) => const Center(
                  child: AntreeText('Empty data'),
                ),
              )),
        ),
      ),
    );
  }
}
