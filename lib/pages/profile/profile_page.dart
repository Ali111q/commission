import 'package:Trip/config/const_wodget/custom_fill_button.dart';
import 'package:Trip/config/constant.dart';
import 'package:Trip/config/utils/const_class.dart';
import 'package:Trip/controller/auth_controller.dart';
import 'package:Trip/fees/fees_page.dart';
import 'package:Trip/main.dart';
import 'package:Trip/pages/statics/statisc_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../config/const_wodget/custom_scaffold.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2684FF),
        title: Text(
          "الملف الشخصي",
          style: context.theme.textTheme.headlineSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(14),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  "assets/icons/pop.svg",
                )),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: Get.height * 0.24,
            width: Get.width,
            decoration: BoxDecoration(color: Color(0xff2684FF)),
            child: Row(
              children: [
                Gap(10),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xffBFB5FF), width: 2)),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Color(0xffE6D9D9).withOpacity(0.69),
                        blurRadius: 17,
                        offset: Offset(0, 8),
                      )
                    ], shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1724630400&semt=ais_hybrid",
                      ),
                    ),
                  ),
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prefs.getString('fullname') ?? "",
                      style: context.theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.beVietnamPro().fontFamily),
                    ),
                    Text(prefs.getString('email') ?? "",
                        style: context.theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontFamily: GoogleFonts.lato().fontFamily)),
                    Text(
                        timeago.format(
                            DateTime.parse(
                                prefs.getString('creationDate') ?? ""),
                            locale: 'ar'),
                        style: context.theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontFamily: GoogleFonts.lato().fontFamily)),
                  ],
                )
              ],
            ),
          ),
          Gap(10),
          CustomListTileWithDivider(
            title: "سجل المخالفات",
            icon: "assets/icons/invoice.svg",
            onTap: () => Get.to(FeesPage()),
          ),
          CustomListTileWithDivider(
            title: "الاحصائيات",
            icon: "assets/icons/invoice.svg",
            onTap: () => Get.to(StaticsPage()),
          ),
          CustomListTileWithDivider(
            title: "تسجيل خروج",
            icon: "assets/icons/translate.svg",
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('تسجيل خروج'),
                        content: Text('هل تريد تسجيل الخروج'),
                        actions: [
                          CustomFillButton(
                            title: "نعم",
                            width: 100,
                            backgroundColor: Colors.red,
                            onTap: () {
                              controller.logout();
                            },
                          ),
                          CustomFillButton(
                            title: "لا",
                            width: 100,
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ],
                      ));
            },
          ),
        ],
      ),
    );
  }
}

class CustomListTileWithDivider extends StatelessWidget {
  const CustomListTileWithDivider({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Text(title),
          leading: SvgPicture.asset(
            icon,
            color: Colors.black,
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
          child: Divider(
            color: Color(0xffE8E8E8),
          ),
        ),
      ],
    );
  }
}
