import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpRequests {
  final String _URL;

  HttpRequests(this._URL);

  Future<Map<String, dynamic>> getRequest() async {
    try {
      final response = await http.get(Uri.parse('$_URL'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> postRequest(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$_URL'),
        body: json.encode(data), // Veriyi JSON formatına çevirir
        headers: {'Content-Type': 'application/json'},
      );

      Map<String, dynamic> res = {
        'statusCode': response.statusCode,
        'body': response.body
      };

      return res;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
