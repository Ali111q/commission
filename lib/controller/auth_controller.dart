import 'package:Trip/config/constant.dart';

import 'package:Trip/main.dart';
import 'package:Trip/pages/auth/auth_page.dart';
import 'package:Trip/pages/camera/camera_page.dart';

import '../config/utils/routes.dart';
import '../data/api/auth_api.dart';

class AuthController extends GetxController {
  //api
  final AuthApi _authApi = AuthApi();

  // variables
  RxBool showPassword = false.obs;
  RxBool saveData = false.obs;
  RxBool loading = false.obs;

  // toggles
  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleSaveData(bool? value) {
    saveData.value = value ?? false;
  }

  // key and controllers
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // methods
  void login() async {
    if (formKey.currentState!.validate()) {
      loading.value = true;
      final email = emailController.text;
      final password = passwordController.text;
      final user = await _authApi.login(email, password);
      loading.value = false;

      if (user != null) {
        prefs.setString("token", user.token);
        prefs.setString("id", user.id);
        prefs.setString("email", user.email);
        prefs.setString("fullname", user.fullName);
        prefs.setString("creationDate", user.creationDate.toIso8601String());
        // prefs.setString("garageId", user.garageId);
        // prefs.setString("garageName", user.garageName);
        Get.offAll(CameraPage());
      }
    }
  }

  void logout() {
    prefs.remove("token");
    prefs.remove("id");
    prefs.remove("email");
    prefs.remove("fullname");
    Get.offAll(AuthPage());
  }
}
