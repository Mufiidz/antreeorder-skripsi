import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/res/custom_color.dart';
import 'package:antreeorder/utils/int_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injection.dart';
import '../../models/order.dart';
import '../../models/summary.dart';
import '../../utils/export_utils.dart';
import 'bloc/confirm_order_bloc.dart';
import 'section/orders_section.dart';
import 'section/payment_section.dart';
import 'section/summary_section.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final List<Order> orders;
  const ConfirmOrderScreen({Key? key, required this.orders}) : super(key: key);

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  late final ConfirmOrderBloc _confirmOrderBloc;

  @override
  void initState() {
    _confirmOrderBloc = getIt<ConfirmOrderBloc>()
      ..add(GetInitialConfirm(
          widget.orders, Summary(title: 'Biaya Layanan', price: 1000)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _confirmOrderBloc,
      child: Scaffold(
        appBar: AntreeAppBar("Confirm Order"),
        body: AntreeState<ConfirmOrderBloc, ConfirmOrderState>(
            _confirmOrderBloc, child: (state, context) {
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: ListView.separated(
                    itemBuilder: (context, index) => _sections(state)[index],
                    separatorBuilder: ((context, index) => const Divider(
                          color: AntreeColors.separator,
                          thickness: 5,
                        )),
                    itemCount: _sections(state).length),
              ),
              Container(
                width: context.mediaSize.width,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, -2))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AntreeText("Total"),
                          AntreeText(state.data.toIdr()),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AntreeButton(
                        "Antree",
                        width: context.mediaSize.width,
                        onclick: () => _antree(state),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  void _antree(ConfirmOrderState state) {
    final merchantId = widget.orders.first.product?.merchantId;
    if (merchantId != null) {
      final antree = Antree(
          totalPrice: state.data,
          orders: widget.orders,
          merchantId: merchantId);
      _confirmOrderBloc.add(AddAntree(antree));
    }
  }

  List<Widget> _sections(ConfirmOrderState state) => [
        OrdersSection(
          orders: widget.orders,
          subtotal: state.subtotal,
        ),
        const PaymentSection(),
        SummarySection(
          summaries: state.summaries,
        )
      ];
}
