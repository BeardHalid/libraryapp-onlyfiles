import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/classes/Orders.dart';
import 'package:libraryapp/sqlite/OrdersDao.dart';
import 'package:libraryapp/sqlite/SqliteHelper.dart';

final sqliteProvider = Provider<SqliteHelper>((ref) {
  return SqliteHelper();
});

/* final allOrdersProvider =
    StateNotifierProvider<AllOrdersNotifier, List<Orders>>((ref) {
  final sqlitePrv = ref.read(sqliteProvider);
  return AllOrdersNotifier(sqlitePrv);
}); */

final ordersDaoProvider = Provider((ref) => OrdersDao());

final getOrdersProvider = FutureProvider<List<Orders>>((ref) async {
  return ref.read(ordersDaoProvider).getOrders();
});

final deleteOrdersProvider = FutureProvider<void>((ref) async {
  return ref.read(ordersDaoProvider).deleteOrders();
});

final setOrderProvider =
    FutureProvider.family<bool, Orders?>((ref, order) async {
  bool result = false;
  if (order != null) {
    //OrdersDao.setOrder(order);
    result = true;
  } else {
    result = false;
  }
  return result;
});
