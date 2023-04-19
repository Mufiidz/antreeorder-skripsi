import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/base_state.dart';

class AntreeState<Bloc extends StateStreamable<State>, State extends BaseState>
    extends StatelessWidget {
  final Bloc bloc;
  final Widget Function(State state, BuildContext context) child;
  final String textEmpty;
  final Widget? loading;
  final Widget? error;
  const AntreeState(this.bloc,
      {Key? key,
      required this.child,
      this.textEmpty = "Data is Empty",
      this.loading,
      this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Bloc, State>(
      bloc: bloc,
      listenWhen: (previous, current) => current.status == StatusState.failure,
      listener: (context, state) {
        if (state.status == StatusState.failure) {
          logger.d(state.errorMessage);
        }
      },
      builder: (context, state) {
        final data = state.data;
        if (state.status == StatusState.loading) {
          return loading ??
              const Center(
                child: CircularProgressIndicator(),
              );
        } else if (state.status == StatusState.failure) {
          return error ??
              Center(
                child: Text(
                  state.errorMessage,
                ),
              );
        } else if (data is List && data.isEmpty) {
          return Center(
            child: Text(textEmpty),
          );
        } else {
          return child(state, context);
        }
      },
    );
  }
}
