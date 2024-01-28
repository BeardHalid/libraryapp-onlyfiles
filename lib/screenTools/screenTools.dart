import 'package:flutter/material.dart';

double screenWidth(BuildContext context) {
  final screenTools = MediaQuery.of(context).size;
  return screenTools.width;
}

double screenHeight(BuildContext context) {
  final screenTools = MediaQuery.of(context).size;
  return screenTools.height;
}

verticalGap(double height) {
  return SizedBox(
    height: height,
  );
}

horizontalGap(double width) {
  return SizedBox(
    width: width,
  );
}
