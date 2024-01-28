class Address {
  String full_address;
  String postal_code;
  String city_name;
  String county_name;
  Address({
    required this.full_address,
    required this.postal_code,
    required this.city_name,
    required this.county_name,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        full_address: json["full_address"] as String,
        postal_code: json["postal_code"] as String,
        city_name: json["city_name"] as String,
        county_name: json["county_name"] as String);
  }

  Map<String, dynamic> toJson() => {
        "full_address": full_address,
        "postal_code": postal_code,
        "city_name": city_name,
        "county_name": county_name
      };
}
