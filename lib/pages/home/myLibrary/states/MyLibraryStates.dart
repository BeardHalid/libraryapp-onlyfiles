import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/firebase/states/FirebaseStates.dart';

final myBooksProvider = FutureProvider((ref) async {
  final userId = ref.read(authInstanceProvider).currentUser!.uid;
  final firestoreInstance = ref.read(storageInstance);
  return await firestoreInstance
      .collection("users")
      .doc(userId)
      .collection("my_books")
      .get();
});
