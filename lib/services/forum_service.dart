import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class ForumService extends UserService {
  Future<List<Forum>> get(String idRestoran) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    String url = '${RPUrls.baseUrl}/v1/restoran/$idRestoran/forum/';
    http.Response response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return forumFromListJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
