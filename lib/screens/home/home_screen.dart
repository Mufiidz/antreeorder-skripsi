import 'package:antreeorder/components/antree_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AntreeButton(name: "Test", onclick: () {},),
    );
  }
}
