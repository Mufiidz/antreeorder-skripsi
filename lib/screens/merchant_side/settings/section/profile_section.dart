import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final Merchant? merchant;
  const ProfileSection(this.merchant, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            child: Icon(
              Icons.account_circle,
              size: 50,
            ),
          ),
          const AntreeSpacer(),
          AntreeText(
            merchant?.name ?? 'Merchant Name',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: AntreeTextStyle.title.copyWith(fontSize: 25),
          ),
          const AntreeSpacer(),
          GestureDetector(
            onTap: () => context.snackbar
                .showSnackBar(const SnackBar(content: Text("Coming Soon"))),
            child: AntreeText(
              'Edit Profile',
              style: AntreeTextStyle.normal.copyWith(
                  decoration: TextDecoration.underline, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
