import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/classes/Books.dart';
import 'package:libraryapp/pages/categoryDetail/states/CategoryDetailStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomCard.dart';
import 'package:libraryapp/widgets/CustomHeader.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class CategoryDetail extends ConsumerStatefulWidget {
  final String categoryName;
  const CategoryDetail({
    super.key,
    required this.categoryName,
  });

  @override
  ConsumerState<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends ConsumerState<CategoryDetail> {
  @override
  Widget build(BuildContext context) {
    final catDetailPrv = ref.watch(catDetailProvider(widget.categoryName));
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Kategori Detayı',
          ),
          toolbarHeight: screenHeight(context) * 0.09,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: catDetailPrv.when(
          data: (data) {
            var catDetails = data.docs;
            if (catDetails.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () {
                  return ref
                      .refresh(catDetailProvider(widget.categoryName).future);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    itemCount: catDetails.length,
                    itemBuilder: (context, index) {
                      var book = Books.fromJson(catDetails[index].data());
                      return CustomCard(
                          bookImage: book.book_image,
                          bookAuthor: book.book_author,
                          bookName: book.book_name);
                    },
                  ),
                ),
              );
            } else {
              return const Center(
                child: CustomText(text: 'Gösterilecek veri bulunamadı!'),
              );
            }
          },
          error: (error, stackTrace) => Center(
            child: CustomText(text: error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
