import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/screens/merchant_side/verify/verify_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/detail_antree_merchant_bloc.dart';

class DetailAntreeScreen extends StatefulWidget {
  final int antreeId;
  const DetailAntreeScreen({Key? key, required this.antreeId})
      : super(key: key);

  @override
  State<DetailAntreeScreen> createState() => _DetailAntreeScreenState();
}

class _DetailAntreeScreenState extends State<DetailAntreeScreen> {
  late final DetailAntreeMerchantBloc _detailAntreeMerchantBloc;
  late AntreeLoadingDialog _loadingDialog;
  @override
  void initState() {
    _detailAntreeMerchantBloc = getIt<DetailAntreeMerchantBloc>();
    _detailAntreeMerchantBloc
        .add(DetailAntreeMerchantEvent.initial(widget.antreeId));
    _loadingDialog = getIt<AntreeLoadingDialog>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AntreeAppBar('Detail Antree'),
      body: RefreshIndicator.adaptive(
        onRefresh: () async => _detailAntreeMerchantBloc
            .add(DetailAntreeMerchantEvent.initial(widget.antreeId)),
        child:
            BlocConsumer<DetailAntreeMerchantBloc, DetailAntreeMerchantState>(
          bloc: _detailAntreeMerchantBloc,
          listener: (context, state) {
            if (state.status == StatusState.failure) {
              _loadingDialog.dismiss();
              context.snackbar.showSnackBar(AntreeSnackbar(
                state.message,
                status: SnackbarStatus.error,
              ));
            }
            if (state.status == StatusState.success) {
              _loadingDialog.dismiss();
              context.snackbar.showSnackBar(AntreeSnackbar(
                state.message,
                status: SnackbarStatus.success,
              ));
            }
            if (state.status == StatusState.idle) {
              _loadingDialog.dismiss();
            }
            if (state.status == StatusState.loading) {
              _loadingDialog.showLoadingDialog(context);
            }
          },
          builder: (context, state) {
            final DetailAntreeButton? detailAntreeButton =
                state.detailAntreeButton;
            return Column(
              children: [
                Expanded(
                    flex: 2,
                    child: AntreeList(state.sections,
                        isSeparated: true,
                        itemBuilder: (context, item, index) => item,
                        separatorBuilder: (context, item, index) =>
                            const Divider(
                              thickness: 5,
                              color: AntreeColors.separator,
                            ))),
                detailAntreeButton == null
                    ? Container()
                    : Container(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: TextButton(
                                  onPressed: () {
                                    final negativeBtn =
                                        detailAntreeButton.negativeActionButton;
                                    if (negativeBtn ==
                                        DetailAntreeBtnAction.cancel) {
                                      _detailAntreeMerchantBloc.add(
                                          DetailAntreeMerchantEvent
                                              .cancelAntree(state.antree));
                                    }
                                    if (negativeBtn ==
                                        DetailAntreeBtnAction.decrease) {
                                      final statusAntree = state.antree.status;
                                      final newAntree = state.antree.copyWith(
                                          status: statusAntree.copyWith(
                                              id: statusAntree.id - 1));
                                      _detailAntreeMerchantBloc.add(
                                          DetailAntreeMerchantEvent
                                              .updateStatus(newAntree));
                                    }
                                    if (negativeBtn ==
                                        DetailAntreeBtnAction.alihkan) {
                                      final statusAntree = state.antree.status;
                                      final newAntree = state.antree.copyWith(
                                          status: statusAntree.copyWith(id: 5));
                                      _detailAntreeMerchantBloc.add(
                                          DetailAntreeMerchantEvent
                                              .updateStatus(newAntree));
                                    }
                                  },
                                  child: Text(
                                      detailAntreeButton.negativeButtonText),
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: Size(100, 50),
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              width: 2, color: Colors.black))),
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: AntreeButton(
                                    detailAntreeButton.positiveButtonText,
                                    onClick: () {
                                  final positiveBtn =
                                      detailAntreeButton.positiveActionButton;
                                  // if (positiveBtn ==
                                  //     DetailAntreeBtnAction.confirm) {
                                  //   _detailAntreeMerchantBloc.add(
                                  //       DetailAntreeMerchantEvent.confirmAntree(
                                  //           state.antree));
                                  // }
                                  if (positiveBtn ==
                                      DetailAntreeBtnAction.increase) {
                                    final statusAntree = state.antree.status;
                                    final newAntree = state.antree.copyWith(
                                        status: statusAntree.copyWith(
                                            id: statusAntree.id + 1));
                                    _detailAntreeMerchantBloc.add(
                                        DetailAntreeMerchantEvent.updateStatus(
                                            newAntree));
                                  }
                                  if (positiveBtn ==
                                      DetailAntreeBtnAction.diambil) {
                                    AppRoute.to(
                                        VerifyScreen(antree: state.antree));
                                  }
                                }),
                              )),
                            ],
                          ),
                        ),
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}
