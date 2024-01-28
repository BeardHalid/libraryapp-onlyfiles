import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libraryapp/classes/Address.dart';
import 'package:libraryapp/classes/Books.dart';
import 'package:libraryapp/classes/Users.dart';
import 'package:libraryapp/widgets/CustomErrorDialog.dart';
import 'package:libraryapp/widgets/CustomSnackBar.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class FirebaseOpts {
  static Future<void> userSignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> signUp(
      String email, String password, dynamic context) async {
    var newUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (newUser.user != null) {
      var user = Users(
          firstName: "",
          surname: "",
          username: "",
          email: email,
          gender: "",
          address: Address(
              full_address: "",
              postal_code: "0",
              city_name: '',
              county_name: ''));
      FirebaseFirestore.instance
          .collection("users")
          .doc(newUser.user!.uid)
          .set(user.toJson());
      /* ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
        content: 'Kullanıcı başarıyla oluşturuldu!',
      )); */
      showCustomSnackBar(
          context: context, content: 'Kullanıcı başarıyla oluşturuldu!');
    } else {
      showDialog(
          context: context,
          builder: (context) => const CustomErrorDialog(
                  content: Center(
                child: CustomText(text: 'Bir hata meydana geldi'),
              )));
    }
    /* newUser.then((result) {
      var user = Users(
          firstName: "",
          surname: "",
          username: "",
          email: email,
          gender: "",
          address: Address(
              full_address: "",
              postal_code: "0",
              city_name: '',
              county_name: ''));
      FirebaseFirestore.instance
          .collection("users")
          .doc(result.user!.uid)
          .set(user.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Kullanıcı başarıyla oluşturuldu!")));
    }).catchError((error) {
      print("Bir hata oluştu : ${error.toString()}");
    }); */
  }

  static Future<UserCredential> signIn(String email, String password) async {
    var currentUser = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return currentUser;
  }

  static dynamic checkUserSign() {
    return FirebaseAuth.instance.authStateChanges();
  }

  static Future<Users?> getUserProps(String id) async {
    var x = await FirebaseFirestore.instance.collection("users").doc(id).get();
    var user = Users.fromJson(x.data() as Map<String, dynamic>);
    return user;
  }

  static Future<void> updateDocument(
      {required String colName,
      required String docId,
      required Map<String, dynamic> data}) async {
    var fsDoc =
        FirebaseFirestore.instance.collection(colName).doc(docId).update(data);
    fsDoc.then((result) {
      log("Document başarıyla güncellendi!");
    }).catchError((error) {
      log("Hata : ${error.toString()}");
    });
  }

  static Future<void> createDocument(
      {required String colName,
      required String docId,
      required Map<String, dynamic> data}) async {
    var fsDoc =
        FirebaseFirestore.instance.collection(colName).doc(docId).set(data);
    fsDoc.then((result) {
      log("Document başarıyla oluşturuldu!");
    }).catchError((error) {
      log("Hata : ${error.toString()}");
    });
  }

  Future<List<Books>> getMyLibBooks(String docId) async {
    var booksList = <Books>[];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(docId)
        .collection("my_books")
        .get()
        .then((books) {
      books.docs.forEach((book) {
        var mapToBook = book.data();
        booksList.add(Books.fromJson(mapToBook));
      });
    });
    return booksList;
  }

  static Future<void> sendOrderToFirebase(
      Map<String, dynamic> map, String userId) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(userId)
        .set(map, SetOptions(merge: true))
        .then((value) {
      print("Sipariş gönderildi!");
    }).catchError((error) {
      print(error.toString());
    });
  }

  static dynamic getCategoryDetails(String categoryName) async {
    var fsCategories = await FirebaseFirestore.instance
        .collection("all_books")
        .where("book_category", isEqualTo: categoryName)
        .get();
    return fsCategories;
  }

  Future<List<String>> getCategories() async {
    var categoryList = <String>[];
    await FirebaseFirestore.instance
        .collection("all_books")
        .get()
        .then((books) {
      books.docs.forEach((element) {
        var e = element.data();
        categoryList.add(e["book_category"]);
      });
    });
    return categoryList;
  }
}
