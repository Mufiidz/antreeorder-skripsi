import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/notification.dart' as notif;
import 'package:antreeorder/models/status_antree.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/detail_antree_screen.dart';
import 'package:antreeorder/screens/merchant_side/home/item_home.dart';
import 'package:antreeorder/screens/merchant_side/settings/setting_merchant_screen.dart';
import 'package:antreeorder/screens/notification/notification_screen.dart';
import 'package:antreeorder/screens/user_side/antree/antree_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc;
  @override
  void initState() {
    _homeBloc = getIt<HomeBloc>();
    _homeBloc.add(GetAllData());
    setupNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeBloc,
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
          onRefresh: () async => _homeBloc.add(GetAllData()),
          child: AntreeState<HomeBloc, HomeState>(
            _homeBloc,
            onRetry: () => _homeBloc.add(GetAllData()),
            child: (state, context) => AntreeList(
              state.data,
              itemBuilder: (context, item, index) => ItemHome(
                  item, (newStatusId) => onSwipeUpdate(item, newStatusId)),
            ),
          ),
        ),
      ),
    );
  }

  onSwipeUpdate(Antree antree, int newStatusId) {
    if (newStatusId == 0) return;
    if (antree.status.id == newStatusId) return;
    StatusAntree statusAntree = antree.status;
    statusAntree = statusAntree.copyWith(id: newStatusId);
    if (antree.status.id != 1) {
      antree = antree.copyWith(status: statusAntree);
    }
    _homeBloc.add(UpadateStatusAntree(antree, antree.status.id == 1));
  }

  Future<void> setupNotification() async {
    final firebaseMessaging = getIt<FirebaseMessaging>();

    firebaseMessaging.onTokenRefresh.listen((newToken) {
      if (newToken.isNotEmpty) {
        _homeBloc.add(UpdateNotificationToken(newToken));
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
    // _homeBloc.streamController.close();
    _homeBloc.close();
    super.dispose();
  }
}
