import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/content_detail.dart';
import 'package:flutter/material.dart';

class DetailAntreeSection extends StatelessWidget {
  final List<ContentDetail> antreeDetails;
  const DetailAntreeSection(this.antreeDetails, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AntreeList<ContentDetail>(
      antreeDetails,
      shrinkWrap: true,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, item, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        child: Row(
          children: [
            Expanded(child: AntreeText(item.title, maxLines: 2, textAlign: TextAlign.start,)),
            Expanded(child: AntreeText(item.value, maxLines: 2, textAlign: TextAlign.end,)),
          ],
        ),
      ),
    );
  }
}
