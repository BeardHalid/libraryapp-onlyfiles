import 'package:libraryapp/classes/Base.dart';

class Books implements Base {
  @override
  String book_author;

  @override
  String book_name;

  @override
  String book_price;

  String book_category;
  String book_image;
  String book_stock;
  Books({
    required this.book_author,
    required this.book_name,
    required this.book_price,
    required this.book_category,
    required this.book_image,
    required this.book_stock,
  });

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
        book_author: json["book_author"] as String,
        book_name: json["book_name"] as String,
        book_price: json["book_price"] as String,
        book_category: json["book_category"] as String,
        book_image: json["book_image"] as String,
        book_stock: json["book_stock"] as String);
  }

  Map<String, dynamic> toJson() => {
        "book_author": book_author,
        "book_name": book_name,
        "book_price": book_price,
        "book_category": book_category,
        "book_image": book_image,
        "book_stock": book_stock
      };
}
