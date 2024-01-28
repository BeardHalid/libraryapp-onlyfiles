import 'package:flutter/material.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class CustomShoppingCard extends StatelessWidget {
  const CustomShoppingCard(
      {this.radius = 16,
      required this.bookImage,
      required this.bookAuthor,
      required this.bookName,
      required this.bookAmount,
      required this.bookPrice,
      super.key});

  final double radius;
  final String bookImage;
  final String bookName;
  final String bookAuthor;
  final String bookAmount;
  final String bookPrice;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      height: screenHeight(context) * 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(radius)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      bookImage,
                      width: 150,
                      height: 150,
                    ),
                    horizontalGap(20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: bookName,
                          fontSize: 18,
                        ),
                        CustomText(text: bookAuthor, fontSize: 16),
                      ],
                    ),
                    CustomText(text: 'Adet : $bookAmount'),
                    CustomText(text: 'Fiyat : $bookPrice')
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
