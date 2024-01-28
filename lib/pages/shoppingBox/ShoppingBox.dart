import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/classes/Orders.dart';
import 'package:libraryapp/firebase/FirebaseOpts.dart';
import 'package:libraryapp/firebase/states/FirebaseStates.dart';
import 'package:libraryapp/pages/shoppingBox/states/ShoppingBoxStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomButton.dart';
import 'package:libraryapp/widgets/CustomHeader.dart';
import 'package:libraryapp/widgets/CustomShoppingCard.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class ShoppingBox extends ConsumerStatefulWidget {
  const ShoppingBox({super.key});

  @override
  ConsumerState<ShoppingBox> createState() => _ShoppingBoxState();
}

class _ShoppingBoxState extends ConsumerState<ShoppingBox> {
  @override
  Widget build(BuildContext context) {
    final userAuthPrv = ref.watch(userAuthProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepet'),
        toolbarHeight: screenHeight(context) * 0.09,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: userAuthPrv.when(
          data: (user) {
            if (user != null) {
              return OrdersWidget(userId: user.uid);
            } else {
              return const Center(
                child: Text("Önce giriş yapmalısınız!"),
              );
            }
          },
          error: ((error, stackTrace) => Center(
                child: Text(error.toString()),
              )),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}

class OrdersWidget extends ConsumerStatefulWidget {
  final String userId;
  OrdersWidget({required this.userId});

  @override
  ConsumerState<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends ConsumerState<OrdersWidget> {
  double sumOfOrders(List<Orders> orders) {
    double sum = 0;
    for (var i = 0; i < orders.length; i++) {
      sum = sum +
          (int.parse(orders[i].book_amount) *
              double.parse(orders[i].book_price));
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final shoppingBoxPrv = ref.watch(shoppingBoxProvider);
    return shoppingBoxPrv.when(
        data: (data) {
          if (data.isNotEmpty) {
            return Column(
              children: [
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var order = data[index];
                      return CustomShoppingCard(
                          bookImage: order.book_image,
                          bookAuthor: order.book_author,
                          bookName: order.book_name,
                          bookAmount: order.book_amount,
                          bookPrice: order.book_price);
                    },
                  ),
                ),
                verticalGap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Toplam : ",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ),
                    data.isNotEmpty
                        ? CustomText(
                            text: "${sumOfOrders(data)} TL",
                            fontSize: 17,
                          )
                        : const CustomText(
                            text: '0 TL',
                            fontSize: 17,
                          )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      width: screenWidth(context) * 0.4,
                      radius: 16,
                      buttonText: "Sipariş Ver",
                      onTap: () {
                        var mapList = shoppingBoxPrv.asData!.value
                            .map((e) => e.toJson())
                            .toList();
                        var newMap = {
                          "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day} - ${TimeOfDay.now().hour}:${TimeOfDay.now().minute}":
                              mapList
                        };
                        FirebaseOpts.sendOrderToFirebase(
                            {"orders": newMap}, widget.userId);
                        ref.read(shoppingBoxProvider.notifier).deleteOrders();
                      },
                    ),
                    CustomButton(
                      width: screenWidth(context) * 0.4,
                      radius: 16,
                      buttonText: "Temizle",
                      onTap: () {
                        ref.read(shoppingBoxProvider.notifier).deleteOrders();
                      },
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(
              child: CustomText(
                text: 'Sepetinizde kitap bulunmuyor!',
                fontSize: 20,
              ),
            );
          }
        },
        error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
