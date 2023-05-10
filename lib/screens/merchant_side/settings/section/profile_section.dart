import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final String name;
  const ProfileSection(this.name, {Key? key}) : super(key: key);

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
            name.isNotEmpty ? name : 'NAME',
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
