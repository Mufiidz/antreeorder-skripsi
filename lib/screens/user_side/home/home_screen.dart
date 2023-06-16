import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/notification.dart' as notif;
import 'package:antreeorder/models/notification.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/detail_antree_screen.dart';
import 'package:antreeorder/screens/notification/notification_screen.dart';
import 'package:antreeorder/screens/user_side/antree/antree_screen.dart';
import 'package:antreeorder/screens/user_side/home/bloc/home_bloc.dart';
import 'package:antreeorder/screens/user_side/merchant/choose_merchant_screen.dart';
import 'package:antreeorder/screens/user_side/setting/setting_user_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';

import 'item_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc;
  int page = 1;
  final PagingController<int, Antree> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _homeBloc = getIt<HomeBloc>();
    _homeBloc.add(HomeEvent.unreadNotification());
    setupNotification();
    _pagingController.addPageRequestListener(
        (pageKey) => _homeBloc.add(HomeEvent.antreesPagination(pageKey)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AntreeAppBar(
          "AntreeOrder",
          showBackButton: false,
          actions: [
            BlocSelector<HomeBloc, HomeState, int>(
              bloc: _homeBloc,
              selector: (state) => state.notificationCounter,
              builder: (context, state) => AntreeBadge(
                state,
                icon: Icons.notifications,
                onClick: () => AppRoute.to(NotificationScreen()),
              ),
            ),
            IconButton(
                onPressed: () => AppRoute.to(const SettingUserScreen()),
                icon: const Icon(Icons.account_circle)),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            page = 1;
            _homeBloc.add(HomeEvent.unreadNotification());
            _pagingController.refresh();
          },
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state.status == StatusState.failure) {
                context.snackbar.showSnackBar(AntreeSnackbar(
                  state.message,
                  status: SnackbarStatus.error,
                ));
              }
              if (state.status == StatusState.idleList) {
                if (state.isLastPage) {
                  _pagingController.appendLastPage(state.data);
                } else {
                  page += 1;
                  _pagingController.appendPage(state.data, page);
                }
              }
            },
            builder: (context, state) => PagedGridView<int, Antree>(
                pagingController: _pagingController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, index) => ItemHome(item)),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2)),
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () => AppRoute.to(const ChooseMerchantScreen()),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> setupNotification() async {
    final firebaseMessaging = getIt<FirebaseMessaging>();

    firebaseMessaging.onTokenRefresh.listen((newToken) {
      if (newToken.isNotEmpty) {
        _homeBloc.add(HomeEvent.updateNotificationToken(newToken));
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

    if (notification.type == NotificationType.antree) {
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
