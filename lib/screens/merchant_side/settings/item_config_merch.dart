import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/res/antree_textstyle.dart';
import 'package:antreeorder/utils/app_route.dart';
import 'package:flutter/material.dart';

import 'bloc/settings_bloc.dart';

class ItemConfigMerch extends StatelessWidget {
  final ConfigMerch configMerch;
  const ItemConfigMerch({Key? key, required this.configMerch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRoute.to(configMerch.destination),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AntreeText(
                  configMerch.title,
                  style: AntreeTextStyle.medium,
                ),
                AntreeText(
                  configMerch.desc,
                  style: AntreeTextStyle.normal
                      .copyWith(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
            const Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}
