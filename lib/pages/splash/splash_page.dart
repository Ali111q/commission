import 'package:Trip/constants/assets.dart';
import 'package:Trip/pages/auth/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/const_wodget/hero_widget.dart';
import '../../main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration(seconds: 2), () {
      // if (prefs.getString("token") == null) {
      Get.offAll(AuthPage());
      // }
      // else {
      //   Get.offAllNamed("/navigation");
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PhotoHero(
          photo: Assets.assetsImagesLogo,
          width: Get.width * 0.5,
          onTap: () {},
        ),
      ),
    );
  }
}
