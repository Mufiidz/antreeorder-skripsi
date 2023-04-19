import 'package:antreeorder/screens/home/item_home.dart';
import 'package:antreeorder/screens/merchant/choose_merchant_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/export_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = List.generate(10, (index) => index + 1);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("AntreeOrder"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: list.length,
          itemBuilder: (context, index) => ItemHome(index: list[index])),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => AppRoute.to(const ChooseMerchantScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
