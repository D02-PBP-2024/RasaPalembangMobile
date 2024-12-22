import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rasapalembang/models/ulasan.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class UlasanService extends UserService {
  Future<List<Ulasan>> get(String idRestoran) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/$idRestoran/ulasan/');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    if (response.statusCode == 200) {
      return ulasanFromListJson(response.body);
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  Future<List<Ulasan>> getByUsername(String username) async {
    await init();
    final uri = Uri.parse('${RPUrls.baseUrl}/v1/profile/$username/ulasan/');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return ulasanFromListJson(response.body);
      default:
        throw Exception('Gagal mengambil data');
    }
  }

  Future<Ulasan> addUlasan(
      int nilai, String deskripsi, String idRestoran) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/$idRestoran/ulasan/');

    final body = jsonEncode({
      'nilai': nilai,
      'deskripsi': deskripsi,
    });

    // Add additional header
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    http.Response response =
        await client.post(uri, body: body, headers: headers);

    // Remove used additional header
    headers.remove('Content-Type');
    await updateCookie(response);

    if (response.statusCode == 201) {
      return ulasanFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('User tidak terautentikasi');
    } else if (response.statusCode == 403) {
      throw Exception('Tindakan tidak diizinkan');
    } else {
      throw Exception('Error lainnya');
    }
  }

  Future<Ulasan> editUlasan(Ulasan ulasan) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/ulasan/${ulasan.pk}/');

    final body = jsonEncode({
      'nilai': ulasan.nilai,
      'deskripsi': ulasan.deskripsi,
    });

    // Add additional header
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    http.Response response =
        await client.put(uri, body: body, headers: headers);

    // Remove used additional header
    headers.remove('Content-Type');
    await updateCookie(response);

    if (response.statusCode == 200) {
      return ulasanFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('User tidak terautentikasi');
    } else if (response.statusCode == 403) {
      throw Exception('Tindakan tidak diizinkan');
    } else {
      throw Exception('Error lainnya');
    }
  }

  Future<Ulasan> deleteUlasan(Ulasan ulasan) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/ulasan/${ulasan.pk}/');

    http.Response response = await client.delete(uri, headers: headers);
    await updateCookie(response);

    int code = response.statusCode;
    if (code == 200) {
      return ulasanFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('User tidak terautentikasi');
    } else if (response.statusCode == 403) {
      throw Exception('Tindakan tidak diizinkan');
    } else {
      throw Exception('Error lainnya');
    }
  }
}
