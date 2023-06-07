import 'dart:io';

import 'package:antreeorder/utils/export_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AntreeImage extends StatelessWidget {
  final String src;
  final BoxFit? fit;
  final double? width;
  final double? height;
  const AntreeImage(this.src, {Key? key, this.fit, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == ImageType.file
        ? Image.file(
            File(src),
            fit: fit,
            height: height,
            width: width,
          )
        : CachedNetworkImage(
            imageUrl: src,
            fit: fit,
            height: height,
            width: width,
          );
  }

  ImageType get type => src.isUrl ? ImageType.network : ImageType.file;
}

enum ImageType { network, file }
