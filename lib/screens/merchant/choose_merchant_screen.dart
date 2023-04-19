import 'package:antreeorder/screens/product/merchant_product_screen.dart';
import 'package:antreeorder/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/export_components.dart';
import '../../di/injection.dart';
import 'bloc/merchant_bloc.dart';
import 'item_choose_merchant.dart';

class ChooseMerchantScreen extends StatefulWidget {
  const ChooseMerchantScreen({Key? key}) : super(key: key);

  @override
  State<ChooseMerchantScreen> createState() => _ChooseMerchantScreenState();
}

class _ChooseMerchantScreenState extends State<ChooseMerchantScreen> {
  late final MerchantBloc _merchantBloc;

  @override
  void initState() {
    _merchantBloc = getIt<MerchantBloc>();
    _merchantBloc.add(const GetMerchants());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MerchantBloc>(
      create: ((context) => _merchantBloc),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AntreeAppBar("Choose Merchant"),
        body: AntreeState<MerchantBloc, MerchantState>(_merchantBloc,
            child: (state, context) => ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final merchant = state.data[index];
                  return ItemChooseMerchant(
                    merchant: merchant,
                    onclick: () =>
                        AppRoute.to(MerchantProductScreen(merchant: merchant)),
                  );
                })),
      ),
    );
  }
}
