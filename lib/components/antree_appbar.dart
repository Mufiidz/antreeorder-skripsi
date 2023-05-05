import 'package:flutter/material.dart';

import 'export_components.dart';

typedef BackPressCallback = Function()?;

class AntreeAppBar extends AppBar {
  final String name;
  final BackPressCallback onBackPressed;
  final bool showBackButton;
  final bool isEnabledBackButton;
  @override
  // ignore: overridden_fields
  final List<Widget>? actions;

  AntreeAppBar(
    this.name, {
    super.key,
    this.onBackPressed,
    this.actions,
    this.showBackButton = true,
    this.isEnabledBackButton = true,
  }) : super(
            title: Text(name),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            leading: showBackButton
                ? AntreeBack(
                    onClick: isEnabledBackButton ? onBackPressed : () {},
                  )
                : null,
            actions: actions);
}
