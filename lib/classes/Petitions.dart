class Petitions {
  String petitionType;
  String status;
  String sender;
  String petition;
  String deviceToken;
  Petitions(
      {required this.petitionType,
      required this.status,
      required this.sender,
      required this.petition,
      required this.deviceToken});

  factory Petitions.fromJson(Map<String, dynamic> json) {
    return Petitions(
        petitionType: json["petition_type"] as String,
        status: json["status"] as String,
        sender: json["sender"] as String,
        petition: json["petition"] as String,
        deviceToken: json["device_token"] as String);
  }

  Map<String, dynamic> toJson() => {
        "petition_type": petitionType,
        "status": status,
        "sender": sender,
        "petition": petition,
        "device_token": deviceToken
      };
}
