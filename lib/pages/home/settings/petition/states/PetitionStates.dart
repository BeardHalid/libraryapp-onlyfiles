import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/firebase/states/FirebaseStates.dart';

final petitionProvider = FutureProvider.family((ref, String? petType) async {
  final firebasePrv = ref.watch(firebaseProvider);

  return petType != null
      ? await firebasePrv
          .collection('petitions')
          .where('petition_type', isEqualTo: petType)
          .get()
      : await firebasePrv.collection('petitions').get();
});
