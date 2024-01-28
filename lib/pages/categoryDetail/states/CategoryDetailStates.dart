import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/firebase/states/FirebaseStates.dart';

final catDetailProvider =
    FutureProvider.family((ref, String categoryName) async {
  final firebasePrv = ref.read(firebaseProvider);
  return firebasePrv
      .collection('all_books')
      .where('book_category', isEqualTo: categoryName)
      .get();
});
