import 'dart:io';

import 'package:Trip/controller/file_controller.dart';
import 'package:Trip/data/api/fees_api.dart';
import 'package:Trip/data/model/fee/add_fees_form.dart';
import 'package:Trip/data/model/fee/fee_model.dart';
import 'package:Trip/data/model/fee/fee_type_model.dart';
import 'package:Trip/data/model/fee/plate_charcter_model.dart';
import 'package:Trip/pages/fee_details/fee_details_page.dart';
import 'package:Trip/pages/registered_fee/registered_fee_page.dart';
import 'package:camera/camera.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';

import '../client/base_client.dart';
import '../config/constant.dart';
import '../data/model/direct_violations.dart';
import '../data/model/fee/plate_car_type_model.dart';
import '../data/model/fee/guvernurate_model.dart';
import '../main.dart';
import '../pages/camera/widget/add_fees_form.dart';
import '../pages/web_view.dart';

class FeesController extends GetxController {
  // api
  final FeesApi _feesApi = FeesApi();
  final FileController fileController = Get.find();
  // location
  Geolocator geolocator = Geolocator();

  // variables
  RxList<GovernurateModel> governorates = <GovernurateModel>[].obs;
  RxList<PlateCharecterModel> plateCharecters = <PlateCharecterModel>[].obs;
  RxList<FeeModel> fees = <FeeModel>[].obs;
  RxInt page = 1.obs;
  int totalPage = 0;
  RxList<PlateCarTypeModel> plateCarTypeModels = <PlateCarTypeModel>[].obs;
  RxList<FeeTypeModel> feeTypes = <FeeTypeModel>[].obs;
  RxBool loading = false.obs;
  Rx<FeeModel?> feesModel = Rx(null);
  RxString plateCharacterSearch = "".obs;

  RxList<DirectViolation> directViolations = <DirectViolation>[].obs;
  RxInt directViolationPage = 1.obs;
  int directViolationTotalPage = 0;
  Rx<DirectViolation?> directViolationModel = Rx(null);
  RxBool paymentLoading = false.obs;
  // form variables and controllers
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController plateNumber = TextEditingController();
  TextEditingController notes = TextEditingController();
  Rx<GovernurateModel?> selectedGovernorate = Rx(null);
  Rx<PlateCharecterModel?> selectedPlateCharacter = Rx(null);
  Rx<PlateCarTypeModel?> selectedPlateCarType = Rx(null);
  Rx<FeeTypeModel?> selectedFeeType = Rx(null);
  AddFeesFormModel? addFeesFormModel;
  RxList<File> imagePath = <File>[].obs;

  // sycles
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUtils();
    getFees(1);
    getDirectViolations(1);

    debounce(selectedGovernorate, (value) {
      if (value != null) {
        getPlateCharacters();
      }
    }, time: Duration(milliseconds: 500));
    debounce(plateCharacterSearch, (value) {
      getPlateCharacters(search: value);
    }, time: Duration(milliseconds: 500));
  }

// methods
  void getGovernurate() async {
    final res = await _feesApi.getGovernorates(page: 0);
    governorates.value = res.data;
  }

  void getLastNumber() async {
    numberController.text = await _feesApi.getLastNumber();
  }

  void _getPlateCarTypes() async {
    var res = await _feesApi.getPlateCarTypes(page: 0);
    plateCarTypeModels.value = res.data;
  }

  void getPlateCharacters({String? search}) async {
    var res = await _feesApi.getPlateCharcter(
        page: 0, governurateId: selectedGovernorate.value!.id, search: search);
    plateCharecters.value = res.data;
  }

  void getFeeTypes() async {
    var res = await _feesApi.getFeeTypes(page: 0);
    feeTypes.value = res.data;
  }

  void getUtils() async {
    getFeeTypes();
    getGovernurate();
    // getLastNumber();
    _getPlateCarTypes();
  }

  Future<void> getFees(int page) async {
    var res = await _feesApi.getFees(page);
    this.page.value = res.page;
    totalPage = res.totalPages;
    fees.value = res.data;
  }

  void handleSelectGovernurate(
    String? value,
  ) {
    selectedGovernorate.value =
        governorates.firstWhere((element) => element.id == value);
  }

  void handleSelectPlateCharacter(
    String? value,
  ) {
    print(value);
    selectedPlateCharacter.value =
        plateCharecters.firstWhere((element) => element.id == value);
  }

  void handleSelectPlateCarType(
    String? value,
  ) {
    selectedPlateCarType.value =
        plateCarTypeModels.firstWhere((element) => element.id == value);
  }

  void handleSelectFeeType(
    String? id,
  ) {
    selectedFeeType.value = feeTypes.firstWhere((element) => element.id == id);
    print(selectedFeeType.value);
  }

  void _collectData() async {
    addFeesFormModel = null;
    if (formKey.currentState!.validate() &&
        selectedGovernorate.value != null &&
        selectedPlateCarType.value != null &&
        selectedFeeType.value != null) {
      loading.value = true;
      Position? currenntLocation = await _getLocation();

      if (currenntLocation != null) {
        if (imagePath.value.isEmpty) {
          Get.snackbar("Error", "Please take a photo");
          return;
        }

        var res =
            await fileController.upload(multiFile: true, files: imagePath);
        if (res.item1) {
          print(res.item2);
          addFeesFormModel = AddFeesFormModel(
              number: int.parse(numberController.text),
              governorateId: selectedGovernorate.value!.id,
              note: notes.text,
              plateCharacterId: selectedPlateCharacter.value?.id,
              plateNumber: plateNumber.text,
              plateTypeId: selectedPlateCarType.value!.id,
              feeFinesId: selectedFeeType.value!.id,
              garageId: prefs.getString("garageId")!,
              images: res.item2,
              lat: currenntLocation.latitude.toString(),
              lng: currenntLocation.longitude.toString(),
              violationLocation: "");
          if (addFeesFormModel != null) {
            var feesRes = await _feesApi.addFees(addFeesFormModel!);

            if (feesRes != null) {
              feesModel.value = feesRes;
              clearData();
              Get.off(RegisteredFeePage());
              Get.snackbar("Success", "Fees added successfully");
            }

            loading.value = false;
          }
        }
      }
    }
  }

  void addFees() async {
    _collectData();
    await _feesApi.addFees(addFeesFormModel!);
    Get.back();
  }

  Future<Position?> _getLocation() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();

    if (locationPermission != LocationPermission.whileInUse ||
        locationPermission != LocationPermission.always) {
      return Geolocator.getCurrentPosition();
    }
  }

  void setImage(List<File?> path) {
    imagePath.value = path.map((e) => e!).toList();
  }

  clearData() {
    numberController.clear();
    plateNumber.clear();
    notes.clear();
    imagePath.clear();
    // selectedGovernorate.value = null;
    selectedPlateCharacter.value = null;
    selectedPlateCarType.value = null;
    selectedFeeType.value = null;
  }

  setFeeModel(FeeModel model) {
    feesModel.value = model;
  }

  void getDirectViolations(int page) async {
    var res = await _feesApi.getDirectViolations(page);
    directViolationPage.value = res?.page ?? 0;
    directViolationTotalPage = res?.totalPages ?? 0;
    directViolations.value = res?.data ?? [];
    return;
  }

  void setDirectViolationModel(DirectViolation model) {
    directViolationModel.value = model;
  }

  void payFine(String id, int type) async {
    paymentLoading.value = true;
    var res = await BaseClient.post(api: '/orders/$id', data: {
      'type': type,
    });
    paymentLoading.value = false;
    if (res.item1) {
      final redirectUrl = res.item2['redirectUrl'];

      // Navigate to the WebView screen
      Get.to(
        WebViewScreen(url: redirectUrl),
        fullscreenDialog: true,
      )?.then((_) async {
        await getFees(1);
        var _fee = fees.firstWhereOrNull((e) => e.id == id);
        if (_fee != null) feesModel.value = _fee;
      });
    }
  }
}
