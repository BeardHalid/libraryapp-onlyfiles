/* import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/classes/Orders.dart';
import 'package:libraryapp/sqlite/SqliteHelper.dart';

class AllOrdersNotifier extends StateNotifier<List<Orders>> {
  SqliteHelper helper;
  AllOrdersNotifier(this.helper) : super([]);

  void getOrders() async {
    final sqlitePrv = await helper.op;
    var list = await sqlitePrv.rawQuery("select * from book_orders");
    var orderList = list.map((e) => Orders.fromJson(e)).toList();
    state = orderList;
  }

  void deleteOrders() async {
    final sqlitePrv = await helper.od();
    await sqlitePrv.rawQuery("delete from book_orders").then((value) {
      if (value.isNotEmpty) {
        state = [];
        log("Sepet boş");
      }
    });
  }

  void setOrder(Orders order) async {
    final sqlitePrv = await helper.od();
    var mapOrder = order.toJson();
    await sqlitePrv.insert("book_orders", mapOrder).then((value) {
      if (value > 0) {
        state = [...state, order];
        log("Kitap sepete eklendi");
      }
    });
  }
}
 */