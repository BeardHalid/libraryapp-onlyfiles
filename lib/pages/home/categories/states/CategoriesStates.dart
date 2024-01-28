import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/firebase/states/FirebaseStates.dart';

final categoriesProvider = FutureProvider((ref) async {
  final firebaseInstance = ref.read(firebaseProvider);
  final result = await firebaseInstance.collection('all_books').get();
  return result;
});
