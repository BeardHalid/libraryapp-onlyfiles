import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/pages/categoryDetail/CategoryDetail.dart';
import 'package:libraryapp/pages/home/categories/states/CategoriesStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomHeader.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class Categories extends ConsumerWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesPrv = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Kategoriler',
        ),
        toolbarHeight: screenHeight(context) * 0.09,
      ),
      body: categoriesPrv.when(
        data: (data) {
          var list = data.docs;
          if (list.isNotEmpty) {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                var item = list[index].data();
                return ListTile(
                  title: CustomText(text: item['book_category'], fontSize: 18),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryDetail(
                                categoryName: item['book_category'])));
                  },
                );
              },
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
      ),
    );
  }
}
