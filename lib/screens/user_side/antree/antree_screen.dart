import 'package:antreeorder/components/antree_appbar.dart';
import 'package:antreeorder/components/antree_button.dart';
import 'package:antreeorder/components/antree_list.dart';
import 'package:antreeorder/components/antree_snackbar.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/antree_bloc.dart';

class AntreeScreen extends StatelessWidget {
  final int antreeId;
  const AntreeScreen(this.antreeId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<AntreeBloc>()..add(AntreeEvent.initial(antreeId)),
      child: Scaffold(
        appBar: AntreeAppBar('Detail Antree'),
        body: BlocConsumer<AntreeBloc, AntreeState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                    flex: 2,
                    child: AntreeList<Widget>(
                      state.sections,
                      itemBuilder: (context, item, index) => item,
                    )),
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
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: AntreeButton(
                      "Home",
                      onClick: () => AppRoute.back(),
                    ),
                  ),
                )
              ],
            );
          },
          listener: (context, state) {
            if (state.status == StatusState.failure) {
              context.snackbar.showSnackBar(AntreeSnackbar(
                state.message,
                status: SnackbarStatus.error,
              ));
            }
          },
        ),
      ),
    );
  }
}
