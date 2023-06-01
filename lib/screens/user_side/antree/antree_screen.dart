import 'package:antreeorder/components/antree_appbar.dart';
import 'package:antreeorder/components/antree_button.dart';
import 'package:antreeorder/components/antree_list.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/antree_bloc.dart';

class AntreeScreen extends StatelessWidget {
  final Antree antree;
  const AntreeScreen(this.antree, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AntreeBloc()..add(AntreeEvent.initial(antree)),
      child: Scaffold(
        appBar: AntreeAppBar('Detail Antree'),
        body: BlocSelector<AntreeBloc, AntreeState, List<Widget>>(
          selector: (state) => state.sections,
          builder: (context, sections) => Column(
            children: [
              Expanded(
                  flex: 2,
                  child: AntreeList<Widget>(
                    sections,
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
          ),
        ),
      ),
    );
  }
}
