import 'package:Trip/config/const_wodget/custom_fill_button.dart';
import 'package:Trip/config/const_wodget/custom_text_form_field.dart';

import 'package:Trip/config/validator/validators.dart';
import 'package:flutter/material.dart';

import '../../config/const_wodget/hero_widget.dart';
import '../../config/constant.dart';
import '../../controller/auth_controller.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  final AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PhotoHero(
              photo: Assets.assetsImagesLogo,
              width: Get.width * 0.4,
              onTap: () {},
            ),
            Text("مرحبا بك في تكت"),
            Text("تسجيل الدخول للمتابعة"),
            Center(
              child: SvgPicture.asset(
                Assets.assetsImagesLogo,
                width: Get.width * 0.3,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Insets.small),
              child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: controller.emailController,
                        validators: [ContainsRule("@", "الايميل غير صالح")],
                        hint: 'البريد الالكتروني',
                        label: '',
                      ),
                      Obx(
                        () => CustomTextFormField(
                          controller: controller.passwordController,
                          validators: [
                            MinLengthRule(
                                8, "كلمة المرور يجب ان تكون اكبر من 8")
                          ],
                          obscureText: !controller.showPassword.value,
                          suffixIcon: IconButton(
                            icon: controller.showPassword.value
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              controller.togglePassword();
                            },
                          ),
                          hint: 'كلمة المرور',
                          label: '',
                        ),
                      ),
                      Container(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Checkbox.adaptive(
                                checkColor: Colors.black,
                                activeColor: Colors.white,
                                value: controller.saveData.value,
                                onChanged: controller.toggleSaveData),
                          ),
                          Text("حفظ المعلومات")
                        ],
                      ),
                      Container(
                        height: 15,
                      ),
                      Obx(
                        () => CustomFillButton(
                          color: Color(0xffB83B40),
                          title: 'تسجيل الدخول',
                          textStyle: context.theme.textTheme.bodyLarge!
                              .copyWith(color: Colors.white),
                          onTap: controller.login,
                          isLoading: controller.loading.value,
                        ),
                      ),
                      Container(
                        height: 5,
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
