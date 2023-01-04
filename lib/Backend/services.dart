import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:map/helper/exported_packages.dart';

class Services {
  Future<List<Cites>?> getCities(String city, String country) async {
    List<Cites>? citesList;
    try {
      var response = await http.get(
          Uri.parse("https://api.api-ninjas.com/v1/geocoding?city=$city&country=$country"),
          headers: {"x-api-key" : "EqxxGbCV/Ta6eGPtWYKM/A==8Ltk3CWCpR0W9A5m"});
      citesList = citesFromJson(response.body);
    } catch (e) {
      log(e.toString());
      return null;
    }

    return citesList;
  }
}