import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:flutter/material.dart';

class LogoutSection extends StatelessWidget {
  final void Function() onTapLogout;
  const LogoutSection({Key? key, required this.onTapLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapLogout,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AntreeText(
              'Logout',
              style: AntreeTextStyle.medium,
              textColor: Colors.red,
            ),
            const Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}
