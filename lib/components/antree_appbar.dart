import 'package:flutter/material.dart';

import 'export_components.dart';

class AntreeAppBar extends AppBar {
  final String name;
  final Function()? onBackPressed;

  AntreeAppBar(this.name, {super.key, this.onBackPressed})
      : super(
          title: Text(name),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: AntreeBack(
            onClick: onBackPressed,
          ),
        );
}
