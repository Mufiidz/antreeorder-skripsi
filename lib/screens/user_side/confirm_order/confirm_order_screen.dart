import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/res/custom_color.dart';
import 'package:antreeorder/screens/user_side/confirm_order/section/seats_section.dart';
import 'package:antreeorder/screens/user_side/home/home_screen.dart';
import 'package:antreeorder/screens/user_side/payment/payment_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/confirm_order_bloc.dart';
import 'section/orders_section.dart';
import 'section/payment_section.dart';
import 'section/summary_section.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final List<Order> orders;
  final Merchant merchant;
  ConfirmOrderScreen({super.key, required this.orders, required this.merchant})
      : assert(orders.isNotEmpty);

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  late final ConfirmOrderBloc _confirmOrderBloc;
  late final AntreeLoadingDialog _dialog;
  bool _isEnabledBack = true;
  bool _isSuccess = false;
  bool _isBayarLangsung = false;

  @override
  void initState() {
    _confirmOrderBloc = getIt<ConfirmOrderBloc>()
      ..add(GetInitialConfirm(widget.orders, widget.merchant.id));
    _dialog = getIt<AntreeLoadingDialog>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _confirmOrderBloc,
      child: WillPopScope(
        onWillPop: () async {
          if (_isSuccess) return false;
          return _isEnabledBack;
        },
        child: Scaffold(
          appBar: AntreeAppBar(
            "Confirm Order",
            isEnabledBackButton: _isEnabledBack,
          ),
          body: BlocConsumer<ConfirmOrderBloc, ConfirmOrderState>(
              bloc: _confirmOrderBloc,
              builder: (context, state) => Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AntreeList<Widget>(_sections(state),
                            isSeparated: true,
                            itemBuilder: (context, section, index) => section,
                            separatorBuilder: (context, state, index) =>
                                const Divider(
                                  color: AntreeColors.separator,
                                  thickness: 5,
                                )),
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
                          padding: const EdgeInsets.only(
                              top: 8, left: 16, right: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                onClick: () => _antree(state),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
              listener: (context, state) {
                _isSuccess = state.status == StatusState.success;
                if (state.status == StatusState.failure) {
                  _dialog.dismiss();
                  context.snackbar.showSnackBar(AntreeSnackbar(
                    state.message,
                    status: SnackbarStatus.error,
                  ));
                }
                if (state.status == StatusState.success) {
                  _dialog.dismiss();
                  context.snackbar.showSnackBar(AntreeSnackbar(
                    state.message,
                    status: SnackbarStatus.success,
                  ));
                  final antree = state.antree;
                  if (_isBayarLangsung && antree != null) {
                    AppRoute.clearAll(PaymentScreen(antree: antree, isClearTop: true,));
                  } else {
                    AppRoute.clearAll(HomeScreen());
                  }
                }
              }),
        ),
      ),
    );
  }

  void _antree(ConfirmOrderState state) {
    if (widget.orders.isEmpty) return;
    if (widget.merchant.id == 0) return;
    _dialog.showLoadingDialog(context);
    setState(() {
      _isEnabledBack = false;
    });

    final antree =
        Antree(totalPrice: state.data, orders: widget.orders, seat: state.seat);
    _confirmOrderBloc.add(AddAntree(antree, widget.merchant, _isBayarLangsung));
  }

  List<Widget> _sections(ConfirmOrderState state) => [
        OrdersSection(
          orders: widget.orders,
          subtotal: state.subtotal,
        ),
        state.seats.isEmpty
            ? Container()
            : SeatsSection(
                seats: state.seats,
                onClick: (seat) => _confirmOrderBloc.add(SelectedSeat(seat)),
              ),
        PaymentSection(
          isBayarLangsung: _isBayarLangsung,
          paymentType: (bool isBayarLangsung) {
            logger.d(isBayarLangsung);
            _isBayarLangsung = isBayarLangsung;
          },
        ),
        SummarySection(
          summaries: state.summaries,
        )
      ];
}
