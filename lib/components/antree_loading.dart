import 'package:flutter/material.dart';

class AntreeLoading extends StatelessWidget {
  const AntreeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
