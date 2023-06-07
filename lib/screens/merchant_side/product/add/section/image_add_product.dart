import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageAddProduct extends StatelessWidget {
  final Function(XFile? file) onImagePick;
  final XFile? file;
  final String? imageUrl;
  const ImageAddProduct(
      {Key? key, required this.onImagePick, this.file = null, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AntreeText(
            'Image Product',
            style: AntreeTextStyle.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          width: context.mediaSize.width,
          child: InkWell(
            onTap: () => _pickImage(),
            child: getImage(context),
          ),
        ),
      ],
    );
  }

  Widget getImage(BuildContext context) {
    final source = file?.path ?? imageUrl;
    return (source != null && source.isNotEmpty)
        ? AntreeImage(
            source,
            height: context.mediaSize.width,
            fit: BoxFit.cover,
          )
        : Container(
            height: 200,
            child: Center(
              child: AntreeText(
                'Click to pick image',
                textColor: Colors.black26,
              ),
            ),
          );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    onImagePick(image);
  }
}
