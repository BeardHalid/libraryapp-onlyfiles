import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/classes/Books.dart';

import 'package:libraryapp/pages/home/home/states/HomeStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomBottomSheet.dart';
import 'package:libraryapp/widgets/CustomCardSwiper.dart';
import 'package:libraryapp/widgets/CustomDialog.dart';
import 'package:libraryapp/widgets/CustomErrorDialog.dart';
import 'package:libraryapp/widgets/CustomHeader.dart';
import 'package:libraryapp/widgets/CustomListView.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        width: screenWidth(context),
        height: 110,
        hasSearch: true,
        headText: 'Ana Sayfa',
        controller: _search,
        hintText: 'Ara',
        showActions: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalGap(20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "...Editörün Seçimi...",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
            verticalGap(20),
            _editorsChoice(context, ref),
            verticalGap(20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "...En Çok Satanlar...",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
            verticalGap(20),
            _theBestSeller(context, ref),
          ],
        ),
      ),
    );
  }
}

Widget _editorsChoice(BuildContext context, WidgetRef ref) {
  final editorsChoicePrv = ref.watch(editorsChoiceProvider);
  return editorsChoicePrv.when(
      data: (data) {
        var booksList = data.docs.map((e) => Books.fromJson(e.data())).toList();
        var bookPictures = booksList.map((e) => e.book_image).toList();
        return CustomCardSwiper(
          swiperList: bookPictures,
          isDataOffline: false,
          autoPlay: true,
          pagination: false,
          height: screenHeight(context) * 0.2,
          viewPort: 0.3,
          scale: 0.5,
          onTap: (index) {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0))),
                context: context,
                builder: (context) {
                  return CustomBottomSheet(
                    headText: 'Sepete Ekle',
                    isDataOffline: false,
                    hasImage: true,
                    image: booksList[index].book_image,
                    texts: [
                      booksList[index].book_name,
                      booksList[index].book_author,
                      booksList[index].book_price
                    ],
                    buttonText: 'Sepete Ekle',
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return const CustomErrorDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(child: Text('Merhaba')),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                });
          },
        );
      },
      error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
      loading: () => const Center(
            child: CircularProgressIndicator(),
          ));
}

Widget _theBestSeller(BuildContext context, WidgetRef ref) {
  final bestsellerPrv = ref.watch(bestSellerProvider);
  return bestsellerPrv.when(
      data: (data) {
        var booksList = data.docs.map((e) => Books.fromJson(e.data())).toList();
        return CustomListView(
          list: booksList,
          showButton: true,
          buttonTap: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return CustomDialog(
                  title: 'Sepete Ekle',
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(child: Text('Merhaba')),
                    ],
                  ),
                  actions: [
                    TextButton(onPressed: () {}, child: const Text('Ekle')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('İptal')),
                  ],
                );
              },
            );
          },
        );
      },
      error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
      loading: () => const Center(
            child: CircularProgressIndicator(),
          ));
}
