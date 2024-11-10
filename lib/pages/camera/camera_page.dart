import 'dart:io';

import 'package:Trip/config/constant.dart';
import 'package:Trip/controller/fee_controller.dart';
import 'package:Trip/fees/Fees_page.dart';
import 'package:Trip/pages/image_preview/image_privew_page.dart';
import 'package:Trip/pages/profile/profile_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../config/const_wodget/custom_scaffold.dart';
import '../../data/model/fee/add_fees_form.dart';
import '../../main.dart';
import 'helper/media_size_clipper.dart';
import 'widget/add_fees_form.dart';
import 'widget/app_bar_container.dart';
import 'widget/galiry_button.dart';

class CameraPage extends StatefulWidget {
  CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  final FeesController feesController = Get.put(FeesController());
  int flashMode = 0;
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      // controller.setDescription(CameraDescription(name: 'name', lensDirection: CameraLensDirection.front, sensorOrientation: 0));
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // final CameraPageController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return CustomScaffold(
        // backgroundColor: Colors.amber,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            AppBarContainer(
              ontap: () {
                Get.to(ProfilePage());
              },
              icon: SvgPicture.asset(Assets.assetsIconsProfile),
            ),
            Expanded(child: Container()),
            AppBarContainer(
              ontap: () {
                Get.to(FeesPage());
              },
              icon: SvgPicture.asset(Assets.assetsIconsCategory),
            ),
            SizedBox(width: Insets.small),
          ],
        ),
        body: Container(
          height: Get.height,
          child: Stack(
            children: [
              Builder(builder: (context) {
                if (_loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final scale =
                    1 / (controller.value.aspectRatio * mediaSize.aspectRatio);

                return ClipRect(
                    clipper: MediaSizeClipper(mediaSize),
                    child: Transform.scale(
                      scale: scale,
                      alignment: Alignment.topCenter,
                      child: CameraPreview(controller),
                    ));
              }),
              Positioned(
                width: Get.width,
                bottom: Insets.small,
                child: Padding(
                  padding: EdgeInsets.all(Insets.medium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GalleryButton(),
                      _buildCaptureButton(),
                      _buildFilpButton()
                    ],
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  top: Get.height * 0.12,
                  child: IconButton(
                      onPressed: () {
                        if (flashMode == 3) {
                          setState(() {
                            flashMode = 0;
                          });
                        } else {
                          setState(() {
                            flashMode += 1;
                          });
                        }

                        controller.setFlashMode(FlashMode.values[flashMode]);
                      },
                      icon: AppBarContainer(icon: _buildFlashModelIcon())))
            ],
          ),
        ));
  }

  Icon _buildFlashModelIcon() {
    FlashMode mode = FlashMode.values[flashMode];
    switch (mode) {
      case FlashMode.off:
        return Icon(Icons.flash_off_rounded);

      case FlashMode.auto:
        return Icon(Icons.flash_auto);
      case FlashMode.always:
        return Icon(Icons.flash_on);

      default:
        return Icon(Icons.flash_off_rounded);
    }
  }

  GestureDetector _buildCaptureButton() {
    return GestureDetector(
      onTap: () {
        controller.takePicture().then((value) {
          feesController.setImage([File(value.path)]);
          Get.to(ImagePreviewPage(), fullscreenDialog: true);
        });
      },
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 5)),
        child: Container(
          width: 55,
          height: 55,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        ),
      ),
    );
  }

  GestureDetector _buildFilpButton() {
    return GestureDetector(
      onTap: () async {
        switchCamera();
      },
      child: Container(
        padding: EdgeInsets.all(Insets.small),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.35), shape: BoxShape.circle),
        child: SvgPicture.asset(Assets.assetsIconsflip),
      ),
    );
  }

  // First, you need to ensure the function where this code resides is marked as async
  Future<void> switchCamera() async {
    setState(() {
      _loading = true;
    });

    // Dispose of the old controller
    if (controller != null) {
      await controller.dispose();
    }

    // Switch camera based on the current direction
    final newDirection =
        controller?.description.lensDirection == CameraLensDirection.front
            ? CameraLensDirection.back
            : CameraLensDirection.front;

    // Get the new camera
    final newCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == newDirection,
      orElse: () => cameras[0], // Fallback to default camera if not found
    );

    // Initialize the new controller
    controller = CameraController(newCamera, ResolutionPreset.medium);

    try {
      await controller.initialize();
    } catch (e) {
      // Handle initialization error
      print('Error initializing camera: $e');
    }

    setState(() {
      _loading = false;
    });
  }
}
