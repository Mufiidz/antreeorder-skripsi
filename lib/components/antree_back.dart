import 'package:flutter/material.dart';

import '../utils/app_route.dart';

class AntreeBack extends StatelessWidget {
  final Function()? onClick;
  const AntreeBack({Key? key, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => onClick ?? AppRoute.back(),
        icon: const Icon(Icons.arrow_back));
  }
}
