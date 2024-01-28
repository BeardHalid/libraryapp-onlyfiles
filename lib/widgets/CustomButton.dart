import 'package:flutter/material.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.buttonText,
      this.width,
      this.height,
      this.onTap,
      this.radius = 16.0,
      super.key});
  final String buttonText;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          alignment: Alignment.center,
          width: width ?? screenWidth(context) * 0.7,
          height: height ?? 48,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(radius)),
          child: CustomText(
            text: buttonText,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
