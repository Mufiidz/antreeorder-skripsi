import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/content_detail.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:flutter/material.dart';

class DetailProfileSection extends StatelessWidget {
  final List<ContentDetail> profiles;
  const DetailProfileSection({Key? key, required this.profiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AntreeList<ContentDetail>(
      profiles,
      isSeparated: true,
      shrinkWrap: true,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, item, int index) =>
          Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AntreeText(item.title),
            AntreeText(
              item.value,
              textColor: Colors.grey.shade400,
            ),
          ],
        ),
      ),
      separatorBuilder: (context, item, index) => const Divider(
        color: AntreeColors.separator,
      ),
    );
  }
}
