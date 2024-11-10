import 'package:Trip/client/base_client.dart';
import 'package:Trip/data/model/fee/plate_car_type_model.dart';
import 'package:Trip/data/model/fee/add_fees_form.dart';
import 'package:Trip/data/model/fee/fee_model.dart';
import 'package:Trip/data/model/fee/fee_type_model.dart';
import 'package:Trip/data/model/fee/plate_charcter_model.dart';

import '../model/direct_violations.dart';
import '../model/fee/pagging_model.dart';
import '../model/fee/guvernurate_model.dart';

class FeesApi {
  Future<FeeModel?> addFees(AddFeesFormModel from) async {
    final res = await BaseClient.post(
        api: "/commission/vehicle-fees", data: from.toJson());

    if (res.item1) {
      return FeeModel.fromJson(res.item2);
    }
  }

  Future<PaggingModel<FeeModel>> getFees(int page) async {
    final res = await BaseClient.get(
        api: '/commission/vehicle-fees', queryParameters: {"page": page});
    return PaggingModel.fromJson(res, (json) => FeeModel.fromJson(json));
  }

  Future<PaggingModel<GovernurateModel>> getGovernorates(
      {required int page, String? search}) async {
    // Fetch news from the network
    final res = await BaseClient.get(api: '/governorates');
    return PaggingModel.fromJson(
        res, (json) => GovernurateModel.fromJson(json));
  }

  Future<PaggingModel<FeeTypeModel>> getFeeTypes(
      {required int page, String? search}) async {
    // Fetch news from the network
    final res = await BaseClient.get(api: '/fee-fines');
    return PaggingModel.fromJson(res, (json) => FeeTypeModel.fromJson(json));
  }

  Future<PaggingModel<PlateCharecterModel>> getPlateCharcter(
      {required int page,
      required String governurateId,
      String? search}) async {
    // Fetch news from the network
    final res = await BaseClient.get(
        api: '/mobile/plate-characters',
        queryParameters: {"governorateId": governurateId, "name": search});
    return PaggingModel.fromJson(
        res, (json) => PlateCharecterModel.fromJson(json));
  }

  Future<PaggingModel<PlateCarTypeModel>> getPlateCarTypes(
      {required int page, String? search}) async {
    // Fetch news from the network
    final res = await BaseClient.get(api: '/plate-types');
    return PaggingModel.fromJson(
        res, (json) => PlateCarTypeModel.fromJson(json));
  }

  Future<String> getLastNumber() async {
    var res = await BaseClient.get(api: '/vehicle-receipts/last-number?type=2');
    return res["number"];
  }

  Future<PaggingModel<DirectViolation>?> getDirectViolations(int page) async {
    final res = await BaseClient.get(
        api: '/commission/direct-violation', queryParameters: {"page": page});
    return PaggingModel.fromJson(res, (json) => DirectViolation.fromJson(json));
  }
}
