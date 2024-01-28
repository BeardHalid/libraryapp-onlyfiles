import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/firebase/states/FirebaseStates.dart';

final editorsChoiceProvider = FutureProvider((ref) {
  final storagePrv = ref.read(firebaseProvider);
  return storagePrv.collection("editors_choice").get();
});

final bestSellerProvider = FutureProvider((ref) {
  final storagePrv = ref.read(firebaseProvider);
  return storagePrv.collection("bestseller").get();
});

final searchProvider = StateProvider<String>((ref) {
  return '';
});
