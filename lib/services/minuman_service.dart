import 'package:http/http.dart' as http;
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class MinumanService {
  static const String apiUrl = '${RPUrls.baseUrl}/v1/minuman';

  static Future<List<Minuman>> get() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/'));

      if (response.statusCode == 200) {
        return minumanFromJson(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
