import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/models/user.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class ForumService extends UserService {
  Future<List<Forum>> get(String idRestoran) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/$idRestoran/forum/');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    if (response.statusCode == 200) {
      return forumFromListJson(response.body);
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  Future<Forum> addForum(String topik, String pesan, String idRestoran) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/$idRestoran/forum/');

    final body = jsonEncode({
      'topik': topik,
      'pesan': pesan,
    });

    // Add additional header
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    http.Response response =
        await client.post(uri, body: body, headers: headers);

    // Remove used additional header
    headers.remove('Content-Type');
    await updateCookie(response);

    if (response.statusCode == 201) {
      return forumFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('User tidak terautentikasi');
    } else if (response.statusCode == 403) {
      throw Exception('Tindakan tidak diizinkan');
    } else {
      throw Exception('Error lainnya');
    }
  }

  Future<Forum> deleteForum(Forum forum) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/forum/${forum.pk}/');

    http.Response response = await client.delete(uri, headers: headers);
    await updateCookie(response);

    int code = response.statusCode;
    if (code == 200) {
      return forumFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('User tidak terautentikasi');
    } else if (response.statusCode == 403) {
      throw Exception('Tindakan tidak diizinkan');
    } else {
      throw Exception('Error lainnya');
    }
  }
}
