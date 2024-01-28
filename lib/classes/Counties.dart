class Counties {
  int county_id;
  String county_name;
  int county_area;
  int county_population;
  Counties({
    required this.county_id,
    required this.county_name,
    required this.county_area,
    required this.county_population,
  });

  factory Counties.fromJson(Map<String, dynamic> json) {
    return Counties(
        county_name: json["name"] as String,
        county_area: json["area"] as int,
        county_id: json["id"] as int,
        county_population: json["population"] as int);
  }
}
