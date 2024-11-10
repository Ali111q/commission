import 'dart:io';

import 'package:Trip/pages/image_preview/image_privew_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/constant.dart';
import '../../../config/extension/file_extenssion.dart';
import '../../../controller/fee_controller.dart';
import 'add_fees_form.dart';

class GalleryButton extends StatelessWidget {
  GalleryButton({
    super.key,
  });
  final FeesController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ImagePicker().pickMultiImage(limit: 5).then((images) async {
          compressImages([...images.map((e) => ImageData(e.path))]).then((val) {
            controller.setImage(val);
          });
          if (images.isNotEmpty) {
            Get.to(ImagePreviewPage(), fullscreenDialog: true);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.all(Insets.small),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.15),
            borderRadius: BorderRadius.circular(Insets.exSmall)),
        child: SvgPicture.asset(Assets.assetsIconsGalery),
      ),
    );
  }
}
