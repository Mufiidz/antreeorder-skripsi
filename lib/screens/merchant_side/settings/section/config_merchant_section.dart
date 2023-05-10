import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:flutter/material.dart';

import '../bloc/settings_bloc.dart';
import '../item_config_merch.dart';

class ConfigMerchantSection extends StatelessWidget {
  final List<ConfigMerch> configs;
  const ConfigMerchantSection(this.configs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AntreeList(
      configs,
      isSeparated: true,
      shrinkWrap: true,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      itemBuilder: (state, configMerch, index) =>
          ItemConfigMerch(configMerch: configMerch),
      separatorBuilder: (state, configMerch, index) => const Divider(
        color: AntreeColors.separator,
      ),
    );
  }
}
