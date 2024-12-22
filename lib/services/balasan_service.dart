import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rasapalembang/models/balasan.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class BalasanService extends UserService {
  Future<List<Balasan>> get(String idForum) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/forum/$idForum/balasan/');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    if (response.statusCode == 200) {
      return balasanFromListJson(response.body);
    } else {
      throw Exception('Error lainnya');
    }
  }

  Future<Balasan> addBalasan(String pesan, String idForum) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/forum/$idForum/balasan/');

    final body = jsonEncode({
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
      return balasanFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('User tidak terautentikasi');
    } else if (response.statusCode == 403) {
      throw Exception('Tindakan tidak diizinkan');
    } else {
      throw Exception('Error lainnya');
    }
  }

  Future<Balasan> editBalasan(Balasan balasan) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/balasan/${balasan.pk}/');

    final body = jsonEncode({
      'pesan': balasan.pesan,
    });

    // Add additional header
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    http.Response response =
        await client.put(uri, body: body, headers: headers);

    // Remove used additional header
    headers.remove('Content-Type');
    await updateCookie(response);

    if (response.statusCode == 200) {
      return balasanFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('User tidak terautentikasi');
    } else if (response.statusCode == 403) {
      throw Exception('Tindakan tidak diizinkan');
    } else {
      throw Exception('Error lainnya');
    }
  }

  Future<Balasan> deleteBalasan(Balasan balasan) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/balasan/${balasan.pk}/');

    http.Response response = await client.delete(uri, headers: headers);
    await updateCookie(response);

    int code = response.statusCode;
    if (code == 200) {
      return balasanFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('User tidak terautentikasi');
    } else if (response.statusCode == 403) {
      throw Exception('Tindakan tidak diizinkan');
    } else {
      throw Exception('Error lainnya');
    }
  }
}
