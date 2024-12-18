import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class MakananService extends UserService {
  Future<List<Makanan>> get() async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    const String url = '${RPUrls.baseUrl}/v1/minuman/';

    http.Response response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return makananFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}