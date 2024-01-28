import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/firebase/FirebaseOpts.dart';

final authInstanceProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final storageInstance = Provider((ref) {
  var instance = FirebaseFirestore.instance;
  instance.settings = const Settings(persistenceEnabled: true);
  return instance;
});

final userAuthProvider = StreamProvider<User?>((ref) {
  return ref.read(authInstanceProvider).authStateChanges();
});

final firebaseOptsProvider = Provider<FirebaseOpts>((ref) {
  return FirebaseOpts();
});
