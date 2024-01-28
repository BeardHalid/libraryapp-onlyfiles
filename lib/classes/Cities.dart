class Cities {
  String city_name;
  Cities({
    required this.city_name,
  });

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(city_name: json["name"] as String);
  }
}
