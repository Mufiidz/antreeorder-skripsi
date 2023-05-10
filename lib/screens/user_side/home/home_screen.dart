import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/screens/user_side/home/bloc/home_bloc.dart';
import 'package:antreeorder/screens/user_side/merchant/choose_merchant_screen.dart';
import 'package:antreeorder/screens/user_side/setting/setting_user_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc;
  late final String userId;

  @override
  void initState() {
    _homeBloc = getIt<HomeBloc>();
    final sharedPrefs = getIt<SharedPrefsRepository>();
    userId = sharedPrefs.id;
    if (userId.isNotEmpty) {
      _homeBloc.add(GetAntrians(userId));
    }
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
            IconButton(
                onPressed: () {
                  AppRoute.to(const SettingUserScreen());
                },
                icon: const Icon(Icons.account_circle))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async => _homeBloc.add(GetAntrians(userId)),
          child: AntreeState<HomeBloc, HomeState>(
            _homeBloc,
            onRetry: () => _homeBloc.add(GetAntrians(userId)),
            child: (state, context) => GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: state.data.length,
                itemBuilder: (context, index) => ItemHome(state.data[index])),
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () => AppRoute.to(const ChooseMerchantScreen()),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
