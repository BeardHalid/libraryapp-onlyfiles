import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/classes/Books.dart';
import 'package:libraryapp/firebase/states/FirebaseStates.dart';
import 'package:libraryapp/pages/home/myLibrary/states/MyLibraryStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomCard.dart';
import 'package:libraryapp/widgets/CustomHeader.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class MyLibrary extends ConsumerWidget {
  const MyLibrary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAuthPrv = ref.watch(userAuthProvider);

    return Scaffold(
      appBar: CustomHeader(
        width: screenWidth(context),
        height: screenHeight(context) * 0.15,
        hasSearch: false,
        headText: 'Kitaplarım',
        showActions: true,
      ),
      body: userAuthPrv.when(
        data: (user) {
          if (user != null) {
            final myBooksPrv = ref.watch(myBooksProvider);
            return myBooksPrv.when(
                data: (data) {
                  var bookList = data.docs;
                  if (bookList.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: () {
                        return ref.refresh(myBooksProvider.future);
                      },
                      child: ListView.builder(
                        itemCount: bookList.length,
                        itemBuilder: (context, index) {
                          var book = Books.fromJson(bookList[index].data());
                          return CustomCard(
                              bookImage: book.book_image,
                              bookAuthor: book.book_author,
                              bookName: book.book_name);
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CustomText(
                        text: 'Kitaplığınızda hiç kitap bulunmuyor!',
                        fontSize: 18,
                      ),
                    );
                  }
                },
                error: (error, stackTrace) => Center(
                      child: CustomText(
                        text: error.toString(),
                        fontSize: 18,
                      ),
                    ),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ));
          } else {
            return const Center(
              child: CustomText(
                align: TextAlign.center,
                text:
                    'Kitaplarınızı görüntüleyebilmek için giriş yapmalısınız!',
                fontSize: 20,
              ),
            );
          }
        },
        error: (error, stackTrace) => Center(
          child: CustomText(
            text: error.toString(),
            fontSize: 20,
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
