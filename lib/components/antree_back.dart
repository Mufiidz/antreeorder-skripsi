import 'package:flutter/material.dart';

import '../utils/app_route.dart';

class AntreeBack extends StatelessWidget {
  const AntreeBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => AppRoute.back(), icon: const Icon(Icons.arrow_back));
  }
}
