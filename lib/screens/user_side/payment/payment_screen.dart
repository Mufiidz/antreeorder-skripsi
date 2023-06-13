import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/screens/user_side/home/home_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bloc/payment_bloc.dart';

class PaymentScreen extends StatefulWidget {
  final Antree antree;
  final bool isClearTop;
  const PaymentScreen(
      {Key? key, required this.antree, required this.isClearTop})
      : super(key: key);
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController _controller;
  late final PaymentBloc _paymentBloc;
  late final AntreeLoadingDialog _loadingDialog;
  @override
  void initState() {
    _paymentBloc = getIt<PaymentBloc>();
    _loadingDialog = getIt<AntreeLoadingDialog>();
    final url = widget.antree.payment?.redirectUrl;
    logger.d(url);
    _controller = getIt<WebViewController>();
    if (url != null && url.isNotEmpty) {
      _controller.loadRequest(Uri.parse(url));
    }
    _controller.setNavigationDelegate(_navigationDelegate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isClearTop) {
          AppRoute.clearTopTo(HomeScreen());
        } else {
          AppRoute.back();
        }
        return true;
      },
      child: Scaffold(
        body: RefreshIndicator(
            onRefresh: () async => _controller.reload(),
            child: BlocListener<PaymentBloc, PaymentState>(
              bloc: _paymentBloc,
              listener: (context, state) {
                if (state.status == StatusState.loading) {
                  _loadingDialog.showLoadingDialog(context);
                }
                if (state.status == StatusState.idle) {
                  _loadingDialog.dismiss();
                }
                if (state.status == StatusState.success) {
                  _loadingDialog.dismiss();
                  context.snackbar.showSnackBar(AntreeSnackbar(
                    state.message,
                  ));
                  AppRoute.clearTopTo(HomeScreen());
                }
                if (state.status == StatusState.failure) {
                  _loadingDialog.dismiss();
                  context.snackbar.showSnackBar(AntreeSnackbar(
                    state.message,
                    status: SnackbarStatus.error,
                  ));
                  AppRoute.clearTopTo(HomeScreen());
                }
              },
              child: WebViewWidget(controller: _controller),
            )),
      ),
    );
  }

  NavigationDelegate get _navigationDelegate => NavigationDelegate(
        onProgress: (progress) =>
            _paymentBloc.add(PaymentEvent.loadingPayment(progress != 100)),
        onPageFinished: (url) =>
            _paymentBloc.add(PaymentEvent.loadingPayment(false)),
        onNavigationRequest: (NavigationRequest request) {
          if (request.url
              .startsWith('https://id.my.mufidz.antreeorder/payment/success')) {
            _loadingDialog.showLoadingDialog(context);
            _paymentBloc.add(PaymentEvent.successPayment(widget.antree));
            return NavigationDecision.prevent;
          }
          if (request.url
              .startsWith('https://id.my.mufidz.antreeorder/payment/error')) {
            context.snackbar.showSnackBar(AntreeSnackbar(
              'Error cant accept payment',
              status: SnackbarStatus.error,
            ));
            AppRoute.clearTopTo(HomeScreen());
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      );
}
