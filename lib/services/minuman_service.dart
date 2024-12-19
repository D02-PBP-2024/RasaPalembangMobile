import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class MinumanService extends UserService {
  Future<List<Minuman>> get() async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/minuman/');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    if (response.statusCode == 200) {
      return minumanFromListJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
