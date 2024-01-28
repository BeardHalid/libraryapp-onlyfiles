import 'package:flutter/material.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomButton.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {this.height,
      this.width,
      required this.headText,
      required this.isDataOffline,
      required this.hasImage,
      this.texts,
      this.image,
      required this.buttonText,
      this.onTap,
      super.key});

  final double? height;
  final double? width;
  final String headText;
  final bool isDataOffline;
  final bool hasImage;
  final String? image;
  final List<String>? texts;
  final String buttonText;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? screenWidth(context),
      height: height ?? screenHeight(context) / 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            verticalGap(5),
            Center(
              child: CustomText(
                text: headText,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            isDataOffline
                ? hasImage
                    ? Image.asset(image!)
                    : const SizedBox()
                : hasImage
                    ? Image.network(
                        image!,
                        width: 200,
                        height: 200,
                      )
                    : const SizedBox(),
            texts != null
                ? Column(
                    children: texts!
                        .map((e) => CustomText(
                              text: e,
                              fontSize: 18,
                            ))
                        .toList(),
                  )
                : verticalGap(20),
            CustomButton(
              buttonText: buttonText,
              radius: 16.0,
              width: screenWidth(context),
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
