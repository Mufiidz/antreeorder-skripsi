import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/content_detail.dart';
import 'package:antreeorder/utils/datetime_ext.dart';
import 'package:flutter/material.dart';

class DetailAntreeSection extends StatefulWidget {
  final Antree antree;
  const DetailAntreeSection(this.antree, {Key? key}) : super(key: key);

  @override
  State<DetailAntreeSection> createState() => _DetailAntreeSectionState();
}

class _DetailAntreeSectionState extends State<DetailAntreeSection> {
  late List<ContentDetail> detailsAntree;

  @override
  void initState() {
    super.initState();
    detailsAntree = [
      ContentDetail(title: "Status", value: widget.antree.status.message),
      ContentDetail(title: "Antree ID", value: widget.antree.id.toString()),
      ContentDetail(
          title: "Tanggal Pembelian",
          value: widget.antree.createdAt
                  ?.toStringDate(pattern: 'EEEE, dd MMMM yyyy HH:mm') ??
              '-'),
    ];
    if (widget.antree.takenAt != null) {
      detailsAntree.add(ContentDetail(
          title: "Tanggal Pengambilan",
          value: widget.antree.takenAt
                  ?.toStringDate(pattern: 'EEEE, dd MMMM yyyy HH:mm') ??
              '-'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AntreeList<ContentDetail>(
      detailsAntree,
      shrinkWrap: true,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, item, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
                child: AntreeText(
              item.title,
              maxLines: 2,
              textAlign: TextAlign.start,
            )),
            Expanded(
                child: AntreeText(
              item.value,
              maxLines: 2,
              textAlign: TextAlign.end,
            )),
          ],
        ),
      ),
    );
  }
}
