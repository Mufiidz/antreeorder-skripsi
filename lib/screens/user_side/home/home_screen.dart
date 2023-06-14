import 'package:antreeorder/models/notification.dart' as notif;
import 'package:antreeorder/models/notification.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/detail_antree_screen.dart';
import 'package:antreeorder/screens/user_side/antree/antree_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/screens/notification/notification_screen.dart';
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
          onRefresh: () async => _homeBloc.add(GetAllData()),
          child: BlocSelector<HomeBloc, HomeState, List<Antree>>(
            bloc: _homeBloc,
            selector: (state) => state.data,
            builder: (context, state) {
              return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: state.length,
                  itemBuilder: (context, index) => ItemHome(state[index]));
            },
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

    if (notification.type == NotificationType.antree) {
      if (isMerchant) {
        AppRoute.to(DetailAntreeScreen(antreeId: notification.contentId));
      } else {
        AppRoute.to(AntreeScreen(notification.contentId));
      }
    }
  }
}
