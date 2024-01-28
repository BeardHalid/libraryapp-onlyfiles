import 'package:libraryapp/classes/Address.dart';

class Users {
  String? firstName;
  String? surname;
  String? username;
  String? email;
  String? gender;
  Address? address;
  Users({
    this.firstName,
    this.surname,
    this.username,
    this.email,
    this.gender,
    this.address,
  });

  Map<String, dynamic> toJson() => {
        "firstname": firstName,
        "surname": surname,
        "username": username,
        "email": email,
        "gender": gender,
        "address": {
          "full_address": address!.full_address,
          "postal_code": address!.postal_code,
          "city_name": address!.city_name,
          "county_name": address!.county_name
        }
      };

  factory Users.fromJson(Map<String, dynamic> json) {
    var addressJson = json["address"] as Map<String, dynamic>;
    var address = Address.fromJson(addressJson);
    return Users(
        firstName: json["firstname"] as String,
        surname: json["surname"] as String,
        username: json["username"] as String,
        email: json["email"] as String,
        gender: json["gender"] as String,
        address: address);
  }
}
