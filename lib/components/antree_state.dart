import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/base_state2.dart';

class AntreeState<Bloc extends StateStreamable<State>, State extends BaseState>
    extends StatelessWidget {
  final Bloc bloc;
  final Widget Function(State state, BuildContext context) child;
  final void Function(BuildContext context, State state)? onError;
  final void Function(BuildContext context, State state)? onSuccess;
  final void Function()? onRetry;
  final String textEmpty;
  final Widget? loading;
  final Widget? error;
  final AntreeLoadingDialog? loadingDialog;
  const AntreeState(this.bloc,
      {Key? key,
      required this.child,
      this.textEmpty = "Data is Empty",
      this.loading,
      this.error,
      this.onError,
      this.onSuccess,
      this.loadingDialog,
      this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Bloc, State>(
      bloc: bloc,
      listener: (context, state) {
        // logger.d('baseState -> $state');
        if (state.status == StatusState.failure) {
          loadingDialog?.dismiss();
          if (onError != null) {
            onError!(context, state);
          } else {
            if (state.message.contain('cancel', ignoreCase: true)) return;
            showError(context, state.message);
          }
        }
        if (state.status == StatusState.success) {
          loadingDialog?.dismiss();
          if (onSuccess != null) {
            onSuccess!(context, state);
          }
        }
      },
      builder: (context, state) {
        final data = state.data;
        if (state.status == StatusState.loading) {
          return loading ?? const AntreeLoading();
        }
        if (state.status == StatusState.failure) {
          return error ?? retryWidget(context, state.message);
        }
        if (data is List && data.isEmpty) {
          return retryWidget(context, textEmpty);
        }
        return child(state, context);
      },
    );
  }

  Widget retryWidget(BuildContext context, String message) => Container(
        width: context.mediaSize.width,
        height: context.mediaSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AntreeText(
              message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const AntreeSpacer(),
            TextButton(onPressed: onRetry, child: const Text('Retry'))
          ],
        ),
      );

  void showError(BuildContext context, String message) {
    context.snackbar.showSnackBar(AntreeSnackbar(
      message,
      status: SnackbarStatus.error,
    ));
  }
}
