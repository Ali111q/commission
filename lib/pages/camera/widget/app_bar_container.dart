import 'package:flutter/material.dart';

import '../../../config/utils/const_class.dart';

class AppBarContainer extends StatelessWidget {
  AppBarContainer({super.key, required this.icon, this.ontap});
  final Widget icon;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.6),
        ),
        child: icon,
      ),
    );
  }
}
