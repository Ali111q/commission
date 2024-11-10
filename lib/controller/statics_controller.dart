import 'dart:ffi';

import 'package:Trip/config/constant.dart';
import 'package:Trip/data/api/statics_api.dart';
import 'package:get/get.dart';

import '../data/model/statics_model.dart';

class StaticsController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<Statics?> statics = Rx(null);
  StaticsApi staticsApi = StaticsApi();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    isLoading.value = true;
    await getStatics();
    isLoading.value = false;
  }

  Future<void> getStatics() async {
    statics.value = await staticsApi.getStatics();
  }
}
