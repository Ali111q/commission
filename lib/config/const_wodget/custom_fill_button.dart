import 'package:Trip/config/const_wodget/ink_me.dart';
import 'package:Trip/config/constant.dart';
import 'package:Trip/config/utils/const_class.dart';
import 'package:flutter/material.dart';

class CustomFillButton extends StatelessWidget {
  final String title;
  final Widget? loading;
  final Color? color;
  final Color? backgroundColor;
  final void Function()? onTap;
  final Widget? icon;
  final double? width;
  final double? padding;
  final Border? border;
  bool isLoading;
  final TextStyle? textStyle;
  CustomFillButton(
      {super.key,
      required this.title,
      this.color,
      this.loading,
      this.isLoading = false,
      this.onTap,
      this.backgroundColor,
      this.icon,
      this.width,
      this.textStyle,
      this.padding,
      this.border});

  @override
  Widget build(BuildContext context) {
    return InkMe(
        onTap: onTap,
        child: Container(
          width: width ?? context.width,
          padding: EdgeInsets.symmetric(
              horizontal: Insets.medium, vertical: padding ?? Insets.small + 4),
          decoration: BoxDecoration(
            border: border,
            borderRadius: BorderRadius.circular(Insets.small),
            color:
                backgroundColor ?? color ?? context.theme.colorScheme.primary,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ))
                : Row(
                    children: [
                      icon == null
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Insets.small),
                              child: icon ?? Container(),
                            ),
                      Text(
                        title,
                        style: textStyle ??
                            context.theme.textTheme.titleSmall!.copyWith(
                              color: color ?? context.theme.colorScheme.surface,
                            ),
                      ),
                    ],
                  ),
          ]),
        ));
  }
}

class CustomOutLineButton extends StatelessWidget {
  final String title;
  final Widget? loading;
  final Widget? icon;
  final double? padding;
  bool isLoading;
  final Color? color;
  final void Function()? onTap;
  final Color? backgroundColor;
  final double? borderRadius;
  CustomOutLineButton(
      {super.key,
      required this.title,
      this.loading,
      this.icon,
      this.padding,
      this.color,
      this.onTap,
      this.isLoading = false,
      this.backgroundColor,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return InkMe(
      onTap: onTap,
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(
            horizontal: Insets.medium, vertical: padding ?? Insets.small + 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? Insets.large),
          color: backgroundColor ?? Colors.transparent,
          border: Border.all(
            color: color ?? context.theme.colorScheme.onPrimaryContainer,
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          isLoading
              ? loading ?? Container()
              : Row(
                  children: [
                    icon == null
                        ? Container()
                        : Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Insets.small),
                            child: icon ?? Container(),
                          ),
                    Text(
                      title,
                      style: icon == null
                          ? context.theme.textTheme.titleSmall!.copyWith(
                              color: color ??
                                  context.theme.colorScheme.onPrimaryContainer,
                            )
                          : context.theme.textTheme.titleSmall!.copyWith(
                              color: color ??
                                  context.theme.colorScheme.onPrimaryContainer,
                            ),
                    ),
                  ],
                ),
        ]),
      ),
    );
  }
}
