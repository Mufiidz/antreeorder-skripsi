import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/screens/merchant_side/home/item_home.dart';
import 'package:antreeorder/screens/merchant_side/settings/setting_merchant_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc;
  late final String merchantId;
  @override
  void initState() {
    _homeBloc = getIt<HomeBloc>();
    final merchant = getIt<SharedPrefsRepository>().account?.merchant;
    merchantId = merchant?.id ?? '';
    if (merchantId.isNotEmpty) {
      _homeBloc.add(GetAntrians(merchantId));
    }
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
            IconButton(
                onPressed: () => AppRoute.to(const SettingMerchantScreen()),
                icon: const Icon(Icons.account_circle))
          ],
        ),
        // body: StreamBuilder<List<Antree>>(
        //     stream: _homeBloc.streamController.stream,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       } else {
        //         if (snapshot.hasError) {
        //           return Center(
        //             child: Text(snapshot.error.toString()),
        //           );
        //         } else {
        //           return AntreeList(snapshot.data ?? [],
        //               itemBuilder: (context, antree, index) => ItemHome(antree,
        //                   onSwipeChange: (statusId) => _homeBloc
        //                       .add(UpadateStatusAntree(antree.id, statusId))));
        //         }
        //       }
        //     }),
        body: RefreshIndicator(
          onRefresh: () async {
            if (merchantId.isNotEmpty) {
              _homeBloc.add(GetAntrians(merchantId));
            }
          },
          child: AntreeState<HomeBloc, HomeState>(
            _homeBloc,
            child: (state, context) => ListView.builder(
              itemBuilder: (context, index) {
                final antree = state.data[index];
                return ItemHome(antree,
                    onSwipeChange: (statusId) => _homeBloc
                        .add(UpadateStatusAntree(antree.id, statusId)));
              },
              itemCount: state.data.length,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _homeBloc.streamController.close();
    _homeBloc.close();
    super.dispose();
  }
}
