import 'dart:convert';

import 'package:libraryapp/classes/Cities.dart';
import 'package:http/http.dart' as http;
import 'package:libraryapp/classes/Counties.dart';

class HttpOpts {
  Future<List<Cities>> getCities() async {
    var cityList = <Cities>[];
    String url = 'https://turkiyeapi.cyclic.app/api/v1/provinces?fields=name';
    var response = await http.get(Uri.parse(url));
    var jsonBody = jsonDecode(response.body);
    if (jsonBody['status'] == "OK") {
      var mapList = jsonBody['data'] as List<dynamic>;
      mapList.forEach((element) {
        cityList.add(Cities.fromJson(element));
      });
    }
    return cityList;
  }

  Future<List<Counties>> getCountiesOfCity(String cityName) async {
    var countyList = <Counties>[];
    String url =
        'https://turkiyeapi.cyclic.app/api/v1/provinces?name=$cityName&fields=districts';
    var response = await http.get(Uri.parse(url));
    var jsonBody = jsonDecode(response.body);
    if (jsonBody['status'] == "OK") {
      var mapList = jsonBody['data'] as List<dynamic>;
      mapList.forEach((element) {
        var list = element['districts'] as List<dynamic>;
        list.forEach((el) {
          countyList.add(Counties.fromJson(el));
        });
      });
    }
    return countyList;
  }

  Future<List<Counties>> getCounties() async {
    var countyList = <Counties>[];
    String url =
        'https://turkiyeapi.cyclic.app/api/v1/provinces?fields=districts';
    var response = await http.get(Uri.parse(url));
    var jsonBody = jsonDecode(response.body);
    if (jsonBody['status'] == "OK") {
      var mapList = jsonBody['data'] as List<dynamic>;
      mapList.forEach((element) {
        var list = element['districts'] as List<dynamic>;
        list.forEach((el) {
          countyList.add(Counties.fromJson(el));
        });
      });
    }
    return countyList;
  }
}
