import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

class AntreeScreen extends StatelessWidget {
  final Antree antree;
  const AntreeScreen(this.antree, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AntreeText("Your Antree"),
                  const SizedBox(
                    height: 30,
                  ),
                  AntreeText(
                    antree.antreeNum.toString(),
                    style: AntreeTextStyle.title,
                    fontSize: 70,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AntreeText(
                    "Please wait until ${antree.remaining} more people again to reach your order. Thank you.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AntreeButton(
                    "Home",
                    width: double.maxFinite,
                    onclick: () => AppRoute.back(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
