import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rasapalembang/models/favorit.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class FavoritService extends UserService {
  Future<List<Favorit>> get() async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/favorit/');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return favoritFromListJson(response.body);
      default:
        throw Exception('Error lainnya');
    }
  }

  Future<Favorit> put(Favorit favorit) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/favorit/${favorit.pk}/');

    final body = jsonEncode({
      'catatan': favorit.catatan,
    });

    // Add additional header
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    http.Response response =
    await client.put(uri, body: body, headers: headers);

    // Remove used additional header
    headers.remove('Content-Type');
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return favoritFromJson(response.body);
      case 401:
        throw Exception('User tidak terautentikasi');
      case 403:
        throw Exception('Tindakan tidak diizinkan');
      case 404:
        throw Exception('Favorit tidak ditemukan');
      default:
        throw Exception('Error lainnya');
    }
  }

  Future<Favorit> delete(String idfavorit) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/favorit/$idfavorit/');

    http.Response response = await client.delete(uri, headers: headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return favoritFromJson(response.body);
      case 401:
        throw Exception('User tidak terautentikasi');
      case 403:
        throw Exception('Tindakan tidak diizinkan');
      case 404:
        throw Exception('Favorit tidak ditemukan');
      default:
        throw Exception('Error lainnya');
    }
  }

  Future<Favorit> add(Makanan? makanan, Minuman? minuman, Restoran? restoran) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final Uri uri;
    if (makanan != null) {
      uri = Uri.parse('${RPUrls.baseUrl}/v1/makanan/${makanan.pk}/favorit/');
    } else if (minuman != null) {
      uri = Uri.parse('${RPUrls.baseUrl}/v1/minuman/${minuman.pk}/favorit/');
    } else if (restoran != null) {
      uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/${restoran.pk}/favorit/');
    } else {
      uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran');
    }

    // Add additional header
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    http.Response response =
    await client.post(uri, headers: headers);

    // Remove used additional header
    headers.remove('Content-Type');
    await updateCookie(response);

    switch (response.statusCode) {
      case 201:
        return favoritFromJson(response.body);
      case 401:
        throw Exception('User tidak terautentikasi');
      case 403:
        throw Exception('Tindakan tidak diizinkan');
      default:
        throw Exception('Error lainnya');
    }
  }
}
