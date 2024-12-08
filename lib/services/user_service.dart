import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rasapalembang/utils/urls_constants.dart';

class UserService {
  final String apiUrl = '${RPUrls.baseUrl}/v1/profile';

  Future<List<dynamic>> get(String username) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$username/'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
