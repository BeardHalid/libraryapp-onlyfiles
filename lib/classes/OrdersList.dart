class OrdersList {
  List<Map<String, dynamic>> ordersList;
  OrdersList({required this.ordersList});

  Map<String, dynamic> toJson() => {
        "orders": ordersList,
      };

  factory OrdersList.fromJson(Map<String, dynamic> json) {
    return OrdersList(
        ordersList: json["books_list"] as List<Map<String, dynamic>>);
  }
}
