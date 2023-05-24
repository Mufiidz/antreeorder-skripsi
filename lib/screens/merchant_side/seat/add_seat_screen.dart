import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/seat.dart';
import 'package:antreeorder/screens/merchant_side/seat/bloc/seat_bloc.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddSeatScreen extends StatefulWidget {
  const AddSeatScreen({Key? key}) : super(key: key);

  @override
  State<AddSeatScreen> createState() => _AddSeatScreenState();
}

class _AddSeatScreenState extends State<AddSeatScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final SeatBloc _seatBloc;
  late final AntreeLoadingDialog _loadingDialog;
  @override
  void initState() {
    _seatBloc = getIt<SeatBloc>()..add(SeatEvent.getSeats());
    _loadingDialog = getIt<AntreeLoadingDialog>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AntreeAppBar("Add Seat"),
      body: BlocConsumer<SeatBloc, SeatState>(
        bloc: _seatBloc,
        listener: (context, state) {
          if (state.status == StatusState.loading) {
            _loadingDialog.showLoadingDialog(context);
          }
          if (state.status == StatusState.success) {
            context.snackbar.showSnackBar(AntreeSnackbar(state.message));
          }
          if (state.status == StatusState.failure) {
            context.snackbar.showSnackBar(AntreeSnackbar(
              state.message,
              status: SnackbarStatus.error,
            ));
          }
        },
        builder: (context, state) => Column(
          children: [
            Expanded(
              flex: 2,
              child: AntreeList(
                state.data,
                isSeparated: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, item, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(item.title),
                ),
                separatorBuilder: (context, item, index) => Divider(),
              ),
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
                child: FormBuilder(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        const AntreeTextField(
                          'title',
                          label: "Title",
                        ),
                        const AntreeSpacer(),
                        const Row(
                          children: [
                            Expanded(
                              child: AntreeTextField(
                                'capacity',
                                label: "Capacity",
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: AntreeTextField(
                                  'quantity',
                                  label: "Quantity",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const AntreeSpacer(),
                        AntreeButton(
                          'Add Seat',
                          width: context.mediaSize.width,
                          onclick: onClickAdd,
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void onClickAdd() {
    final formKeyState = _formKey.currentState;
    if (formKeyState == null) return;
    if (!formKeyState.validate()) return;
    formKeyState.save();
    final seat = Seat.fromMap(formKeyState.value);

    _seatBloc.add(SeatEvent.addSeat(seat));
  }
}
