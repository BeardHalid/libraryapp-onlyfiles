import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/classes/Orders.dart';
import 'package:libraryapp/sqlite/OrdersDao.dart';

class ShoppingBoxStates extends AsyncNotifier<List<Orders>> {
  OrdersDao dao = OrdersDao();

  @override
  Future<List<Orders>> build() async {
    return getOrders();
  }

  Future<List<Orders>> getOrders() async {
    final list = await dao.getOrders();
    return list;
  }

  Future<void> addOrder(Orders newOrder) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await dao.setOrder(newOrder);
      return getOrders();
    });
  }

  Future<void> deleteOrders() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await dao.deleteOrders();
      return getOrders();
    });
  }
}

final shoppingBoxProvider =
    AsyncNotifierProvider<ShoppingBoxStates, List<Orders>>(() {
  return ShoppingBoxStates();
});
