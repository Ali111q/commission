import 'package:Trip/client/base_client.dart';

import '../model/app_user.dart';

class AuthApi {
  Future<AppUser?> login(String email, String password) async {
    // Simulate a network request
    final res = await BaseClient.post(
        api: "/login", data: {"email": email, "password": password});

    if (res.item1) {
      return AppUser.fromJson(res.item2);
    }
  }
}
