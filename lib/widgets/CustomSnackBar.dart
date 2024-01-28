import 'package:flutter/material.dart';
import 'package:libraryapp/widgets/CustomText.dart';

void showCustomSnackBar(
    {required BuildContext context,
    Color? color,
    double? radius,
    int? duration,
    double? margin,
    required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color ?? Colors.green,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 8)),
      duration: Duration(seconds: duration ?? 2),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(margin ?? 8),
      content: CustomText(
        text: content,
        color: Colors.white,
      )));
}
