import 'package:Trip/controller/fee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/const_wodget/custom_scaffold.dart';
import '../camera/widget/add_fees_form.dart';

class ImagePreviewPage extends StatelessWidget {
  ImagePreviewPage({super.key});
  final FeesController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('الصور'),
      ),
      body: Stack(
        children: [
          PageView(
            children: [
              ...controller.imagePath.map((e) => Image.file(
                    e,
                    width: Get.width,
                    fit: BoxFit.fitWidth,
                  ))
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.96, // Initial size of the bottom sheet
            minChildSize: 0.1, // Minimum size when dragged down
            maxChildSize: 0.96, // Maximum size when dragged up
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: AddFeesForm(
                      // Pass the scrollController for smooth scrolling
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
