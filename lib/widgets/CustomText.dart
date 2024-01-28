import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {required this.text,
      this.color = Colors.black,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.align = TextAlign.start,
      super.key});

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign align;
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: align,
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
