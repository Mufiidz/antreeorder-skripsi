import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/screens/merchant_side/category/bloc/category_bloc.dart';
import 'package:antreeorder/utils/app_context_ext.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'item_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final CategoryBloc _categoryBloc;

  @override
  void initState() {
    _categoryBloc = getIt<CategoryBloc>();
    _categoryBloc.add(GetCategory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AntreeAppBar('My Category'),
      body: BlocListener<CategoryBloc, CategoryState>(
        bloc: _categoryBloc,
        listener: (context, state) {
          final status = state.status;
          if (status == StatusState.success) {
            context.snackbar.showSnackBar(AntreeSnackbar(
              state.message,
              status: SnackbarStatus.success,
            ));
          }
          if (status == StatusState.failure) {
            context.snackbar.showSnackBar(AntreeSnackbar(
              state.message,
              status: SnackbarStatus.error,
            ));
          }
        },
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: BlocSelector<CategoryBloc, CategoryState, List<String>>(
                bloc: _categoryBloc,
                selector: (state) => state.data,
                builder: (context, state) {
                  return state.isEmpty
                      ? const Center(
                          child: Text('Empty Category'),
                        )
                      : AntreeList(
                          state,
                          itemBuilder: (context, category, index) =>
                              ItemCategory(
                            category,
                            onSwipeDelete: () =>
                                _categoryBloc.add(DeleteCategory(category)),
                          ),
                          isSeparated: true,
                        );
                },
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: FormBuilder(
                        key: _formKey,
                        child: const SizedBox(
                          height: 80,
                          child: AntreeTextField(
                            'category',
                            label: 'Category',
                            hint: 'Input category here',
                            initialValue: '',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: addCategory,
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder()),
                        child: const Icon(Icons.add),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addCategory() {
    var category = '';
    final formKeyState = _formKey.currentState;
    if (formKeyState == null) return;
    if (!formKeyState.validate()) return;
    formKeyState.save();

    category = formKeyState.value["category"];

    if (category.isNotEmpty) {
      _categoryBloc.add(AddCategory(category));
    }
    formKeyState.fields.resetForms();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
