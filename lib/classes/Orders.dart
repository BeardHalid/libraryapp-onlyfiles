import 'package:libraryapp/classes/Base.dart';

class Orders implements Base {
  @override
  String book_author;

  @override
  String book_name;

  @override
  String book_price;
  String book_amount;
  String book_image;
  String order_status;
  String date_time;
  Orders(
      {required this.book_author,
      required this.book_name,
      required this.book_price,
      required this.book_amount,
      required this.book_image,
      required this.order_status,
      required this.date_time});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
        book_author: json["book_author"] as String,
        book_name: json["book_name"] as String,
        book_price: json["book_price"] as String,
        book_amount: json["book_amount"] as String,
        book_image: json["book_image"] as String,
        order_status: json["order_status"] as String,
        date_time: json["date_time"] as String);
  }

  Map<String, dynamic> toJson() => {
        "book_name": book_name,
        "book_author": book_author,
        "book_image": book_image,
        "book_amount": book_amount,
        "book_price": book_price,
        "order_status": false,
        "date_time": date_time
      };
}
