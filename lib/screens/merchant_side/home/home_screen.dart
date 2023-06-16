import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/notification.dart' as notif;
import 'package:antreeorder/models/status_antree.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/detail_antree_screen.dart';
import 'package:antreeorder/screens/merchant_side/home/bloc/home_bloc.dart';
import 'package:antreeorder/screens/merchant_side/home/item_home.dart';
import 'package:antreeorder/screens/merchant_side/settings/setting_merchant_screen.dart';
import 'package:antreeorder/screens/notification/notification_screen.dart';
import 'package:antreeorder/screens/user_side/antree/antree_screen.dart';
import 'package:antreeorder/screens/user_side/product/merchant_product_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homebloc;
  int page = 1;
  final PagingController<int, Antree> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _homebloc = getIt<HomeBloc>();
    _homebloc.add(HomeEvent.getAllData());
    setupNotification();
    _pagingController.addPageRequestListener(
        (pageKey) => _homebloc.add(HomeEvent.antreesPagination(pageKey)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homebloc,
      child: Scaffold(
        appBar: AntreeAppBar(
          "Merchant AntreeOrder",
          showBackButton: false,
          actions: [
            BlocSelector<HomeBloc, HomeState, int>(
              selector: (state) => state.notificationCounter,
              builder: (context, state) => AntreeBadge(
                state,
                icon: Icons.notifications,
                onClick: () => AppRoute.to(NotificationScreen()),
              ),
            ),
            IconButton(
                onPressed: () => AppRoute.to(const SettingMerchantScreen()),
                icon: const Icon(Icons.account_circle))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            page = 1;
            _pagingController.refresh();
            _homebloc.add(HomeEvent.getAllData());
          },
          child: BlocConsumer<HomeBloc, HomeState>(
            bloc: _homebloc,
            builder: (context, state) => AntreeList<Antree>.paging(
              _pagingController,
              itemBuilder: (context, item, index) => ItemHome(
                  item, (newStatusId) => onSwipeUpdate(item, newStatusId)),
            ),
            listener: (context, state) {
              if (state.status == StatusState.failure) {
                context.snackbar.showSnackBar(AntreeSnackbar(
                  state.message,
                  status: SnackbarStatus.error,
                ));
              }
              if (state.status == StatusState.idleList) {
                if (state.isLastPage) {
                  _pagingController.appendLastPage(state.antrees);
                } else {
                  page += 1;
                  _pagingController.appendPage(state.antrees, page);
                }
              }
            },
          ),
        ),
        floatingActionButton: BlocSelector<HomeBloc, HomeState, Merchant?>(
          selector: (state) => state.merchant,
          builder: (context, state) => Visibility(
              visible: state != null,
              child: FloatingActionButton.small(
                onPressed: () => onFabClick(state),
                child: const Icon(Icons.add),
              )),
        ),
      ),
    );
  }

  void onFabClick(Merchant? merchant) {
    if (merchant == null || merchant.id == 0) return;
    AppRoute.to(MerchantProductScreen(
      merchant: merchant,
    ));
  }

  onSwipeUpdate(Antree antree, int newStatusId) {
    if (newStatusId == 0) return;
    if (antree.status.id == newStatusId) return;
    StatusAntree statusAntree = antree.status;
    statusAntree = statusAntree.copyWith(id: newStatusId);
    if (antree.status.id != 1) {
      antree = antree.copyWith(status: statusAntree);
    }
    _homebloc.add(HomeEvent.upadateStatusAntree(antree, antree.status.id == 1));
  }

  Future<void> setupNotification() async {
    final firebaseMessaging = getIt<FirebaseMessaging>();

    firebaseMessaging.onTokenRefresh.listen((newToken) {
      if (newToken.isNotEmpty) {
        _homebloc.add(HomeEvent.updateNotificationToken(newToken));
      }
    });

    RemoteMessage? initialMessage = await firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    final data = message.data;
    logger.d(data);
    if (data.isEmpty) return;
    final notification = notif.Notification.fromFirebaseMessaging(data);
    final isMerchant =
        getIt<SharedPrefsRepository>().account?.isMerchant ?? false;

    if (notification.type == notif.NotificationType.antree) {
      if (isMerchant) {
        AppRoute.to(DetailAntreeScreen(antreeId: notification.contentId));
      } else {
        AppRoute.to(AntreeScreen(notification.contentId));
      }
    }
  }

  @override
  void dispose() {
    page = 1;
    _pagingController.dispose();
    super.dispose();
  }
}
