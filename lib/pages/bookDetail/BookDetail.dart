import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/classes/Books.dart';
import 'package:libraryapp/classes/Orders.dart';
import 'package:libraryapp/mobx/MobxOrderAmount.dart';
import 'package:libraryapp/pages/shoppingBox/states/ShoppingBoxStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomErrorDialog.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class BookDetail extends ConsumerWidget {
  final Books? book;

  BookDetail({required this.book});

  var orderAmount = OrderAmount();

  var book_amount = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kitap Detayı',
        ),
        toolbarHeight: screenHeight(context) * 0.09,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Image.network(
                  book!.book_image,
                  width: 300,
                  height: 300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Kitabın Adı : ${book!.book_name}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Kitabın Yazarı : ${book!.book_author}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Açıklama",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Fiyat : ${book!.book_price}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Adet : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Observer(
                      builder: (context) {
                        book_amount = orderAmount.orderAmount;
                        return Text(
                          orderAmount.orderAmount.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          orderAmount.increaseAmount();
                        },
                        child: Icon(Icons.add_circle)),
                    ElevatedButton(
                        onPressed: () {
                          orderAmount.decreaseAmount();
                        },
                        child: Icon(Icons.remove_circle)),
                  ],
                ),
              ),
              ElevatedButton(
                child: Text(
                  "Sepete Ekle",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  var user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    var order = Orders(
                        book_author: book!.book_author,
                        book_name: book!.book_name,
                        book_price: book!.book_price,
                        book_amount: book_amount.toString(),
                        book_image: book!.book_image,
                        order_status: "false",
                        date_time:
                            "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day} - ${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
                    ref.read(shoppingBoxProvider.notifier).addOrder(order);
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return const CustomErrorDialog(
                              content: Text(
                            "Kitap ekleyebilmek için giriş yapmalısınız!",
                            textAlign: TextAlign.center,
                          ));
                        });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
