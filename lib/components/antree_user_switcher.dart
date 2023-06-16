import 'package:antreeorder/res/export_res.dart';
import 'package:flutter/material.dart';

import 'antree_text.dart';

typedef UserSwitcher = void Function(bool);

class AntreeUserSwitcher extends StatelessWidget {
  final bool isUser;
  final UserSwitcher onUserSwitch;
  const AntreeUserSwitcher(
    this.isUser, {
    Key? key,
    required this.onUserSwitch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const AntreeText('Merchant'),
        Switch.adaptive(
          value: isUser,
          onChanged: onUserSwitch,
          inactiveTrackColor: AntreeColors.separator,
        ),
        const AntreeText('User')
      ],
    );
  }
}
