import 'package:Trip/config/const_wodget/custom_fill_button.dart';
import 'package:Trip/config/constant.dart';
import 'package:Trip/pages/fee_details/fee_details_page.dart';
import 'package:flutter/material.dart';

import '../../config/const_wodget/custom_scaffold.dart';

class RegisteredFeePage extends StatelessWidget {
  const RegisteredFeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: Insets.exLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: SvgPicture.asset("assets/icons/registered_fee.svg"),
            ),
            Container(
              width: Get.width * 0.8,
              child: Text("تم تسجيل المخالفة بنجاح",
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.headlineSmall!.copyWith(
                      color: Color(0xff2684FF),
                      fontSize: 36,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(Insets.medium),
              child: Row(
                children: [
                  Expanded(
                      flex: 7,
                      child: CustomOutLineButton(
                        onTap: () {
                          Get.off(FeeDetailsPage());
                        },
                        borderRadius: Insets.small,
                        color: Color(0xff2684FF),
                        title: "تفاصيل المخالفة",
                      )),
                  Gap(Insets.medium),
                  Expanded(
                      flex: 3,
                      child: CustomFillButton(
                        title: "عودة",
                        backgroundColor: Color(0xff2684FF),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
