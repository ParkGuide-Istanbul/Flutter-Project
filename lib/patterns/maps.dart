import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:park_guide_istanbul/patterns/config.dart';
import 'package:park_guide_istanbul/utils/helper.dart';

class MapsApi {
  String _apiKey = Config.getMapsApiKey();

  Future<String> getDistrictFromCoordinates(
      {required double lat, required double lng}) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$_apiKey';
    String district = '';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final jsonResponse = json.decode(res.body);
        //print(jsonResponse['results'][0]['address_components']);
        List<dynamic> addressComponentList =
            jsonResponse['results'][0]['address_components'];

        int i = 0;
        while (addressComponentList[i]['types'][0] !=
            'administrative_area_level_2') {
          i++;
        }
        //jsonResponse['result']['address_components'][3]['long_name'];
        district = addressComponentList[i]['long_name'];
        district = district.toUpperCase();
        district = Helpers.correctDistrictName(district);
      }
    } catch (e) {
      throw Exception(e);
    }

    return district;
  }

  Future<String> getNameFromCoordinates(
      {String? latlng, double? lat, double? lng}) async {
    if (latlng == null && (lat == null || lng == null)) {
      throw Exception('INVALID VALUES FOR MAPS REQUEST.');
    }
    String placeName = '';
    final String url = latlng == null
        ? 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$_apiKey'
        : 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latlng&key=$_apiKey';
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final jsonResponse = json.decode(res.body);
      //print(jsonResponse);
      placeName = jsonResponse['results'][0]['formatted_address'];
    } else {
      throw Exception('Address couldn\'t be obtained.');
    }
    return placeName;
  }

  Future<String> getIdFromAddress(String address) async {
    String placeId = '';
    address = address.replaceAll(' ', '%20');
    address += '%20';
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$address%C3%BCrkiye&inputtype=textquery&key=$_apiKey';

    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final jsonResponse = json.decode(res.body);
      print(jsonResponse);

      if (jsonResponse['status'] == 'ZERO_RESULTS') {
        return 'Address not found.';
      }

      return jsonResponse['candidates'][0]['place_id'];
    } else {
      throw Exception('Adres id bulunamadı');
    }
  }

  Future<Map<String, dynamic>> getCoordinatesFromAddress(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?&place_id=$placeId&key=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final double latitude =
          jsonResponse['result']['geometry']['location']['lat'];
      final double longitude =
          jsonResponse['result']['geometry']['location']['lng'];
      List<dynamic> addressComponentList =
          jsonResponse['result']['address_components'];

      int i = 0;
      while (addressComponentList[i]['types'][0] !=
          'administrative_area_level_2') {
        i++;
      }
      //jsonResponse['result']['address_components'][3]['long_name'];
      String district = addressComponentList[i]['long_name'];
      district = district.toUpperCase();
      return {
        "latitude": latitude,
        "longitude": longitude,
        "district": district
      }; // Enlem ve boylam değerlerini içeren bir map döndürür
    } else {
      throw Exception('API isteği başarısız oldu.');
    }
  }
}
