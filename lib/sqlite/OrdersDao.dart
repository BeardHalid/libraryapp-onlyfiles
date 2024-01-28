import 'package:libraryapp/classes/Orders.dart';
import 'package:libraryapp/sqlite/SqliteHelper.dart';

class OrdersDao {
  final helper = SqliteHelper();

  Future<List<Orders>> getOrders() async {
    var db = await helper.od();

    var orderList = await db.rawQuery("Select * from book_orders");

    var list = orderList.map((e) => Orders.fromJson(e)).toList();

    return list;
  }

  Future<void> setOrder(Orders order) async {
    var db = await helper.od();

    var mapOrder = order.toJson();

    await db.insert("book_orders", mapOrder);

    print(await db.query("book_orders"));
  }

  Future<int> getOrdersCount() async {
    var db = await helper.od();
    var orderList = await db.rawQuery("Select * from book_orders");
    return orderList.length;
  }

  Future<void> deleteOrders() async {
    var db = await helper.od();
    await db.rawDelete("Delete from book_orders");
  }

  // static Future<void> updateOrder(Orders order) async {
  //   var db = await SqliteHelper.opDatabase();
  //   await db.update("book_orders", order.toJson(),
  //       where: 'book_name = ?', whereArgs: [order.book_name]).then((result) {
  //     if (result > 0) {
  //       print("Kitap başarıyla güncellendi!");
  //     } else {
  //       print("Kitap bulunamadı!");
  //     }
  //   }).catchError((error) {
  //     print("Bir hata oluştu : ${error.toString()}");
  //   });
  // }
}
