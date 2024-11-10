import 'package:Trip/data/model/statics_model.dart';

import '../../client/base_client.dart';

class StaticsApi {
  Future<Statics> getStatics() async {
    final res = await BaseClient.get(api: '/commission/analysis');
    return Statics.fromJson(res);
  }
}
