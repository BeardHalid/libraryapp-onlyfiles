import 'package:flutter/material.dart';
import 'package:libraryapp/classes/Books.dart';
import 'package:libraryapp/pages/bookDetail/BookDetail.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomButton.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class CustomListView extends StatelessWidget {
  const CustomListView(
      {required this.list,
      this.listDirection = Axis.vertical,
      this.buttonTap,
      this.showButton = false,
      super.key});

  final List<Books> list;
  final VoidCallback? buttonTap;
  final Axis listDirection;
  final bool showButton;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      height: screenHeight(context) * 0.35,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          scrollDirection: listDirection,
          itemCount: list.length,
          itemBuilder: (context, index) {
            var book = list[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookDetail(book: book)));
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: Image.network(
                            book.book_image,
                          ),
                        ),
                        Column(
                          children: [
                            CustomText(text: book.book_name, fontSize: 17),
                            verticalGap(30),
                            CustomText(
                              text: book.book_author,
                              fontSize: 17,
                            )
                          ],
                        ),
                        showButton
                            ? CustomButton(
                                buttonText: 'Ekle',
                                width: 50,
                                onTap: buttonTap,
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
