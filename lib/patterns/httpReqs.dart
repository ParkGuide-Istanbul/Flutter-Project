import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:park_guide_istanbul/patterns/config.dart';

class HttpRequests {
  final String _URL;
  final String _userToken = Config.getUserToken();

  HttpRequests(this._URL);

  Future<List<String>> quickSearchGetRequest() async {
    try {
      final response = await http.get(Uri.parse(_URL), headers: {
        'Content-Type': 'application/json',
        'authorization-token': Config.getUserToken()
      });
      if (response.statusCode == 200) {
        List<String> quickSearches = [];
        var body = json.decode(response.body);
        print(body);
        for (int i = 0; i < body.length; i++) {
          String searchToAdd = body[i]['lat-lng'];
          quickSearches.add(searchToAdd.replaceAll("-", ","));
        }
        print(quickSearches);
        return quickSearches;
      } else {
        print(response.statusCode);
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> getRequest() async {
    try {
      final response = await http.get(Uri.parse(_URL), headers: {
        'Content-Type': 'application/json',
        'authorization-token': Config.getUserToken()
      });

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



  Future<Map<String, dynamic>> postRequest(Map<String, dynamic> data,
      {bool? header}) async {
    print("post req triggered.");
    try {
      print(data);
      final response = await http.post(
        Uri.parse(_URL),
        body: json.encode(data),
        headers: header == null
            ? {'Content-Type': 'application/json'}
            : {
                'Content-Type': 'application/json',
                'authorization-token': Config.getUserToken()
              },
      );

      //print(json.decode(response.body));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {"message": "Operation failed."};
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> nearestParksPostRequest(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(_URL),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'authorization-token': _userToken
        },
      );

      return json.decode(response.body);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
