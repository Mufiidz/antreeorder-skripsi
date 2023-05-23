import 'package:antreeorder/config/api_client.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

extension MapMapper on BaseBody {
  BaseBody get wrapWithData => {"data": this};
  void resetForms() {
    if (this is Map<String,
        FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>) {
      (this as Map<String,
              FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>)
          .entries
          .forEach((element) => element.value.reset());
    }
  }
}
