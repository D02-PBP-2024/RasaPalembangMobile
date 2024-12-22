import 'dart:convert';
import 'dart:io';

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

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/makanan/');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return makananFromListJson(response.body);
      default:
        throw Exception('Gagal mengambil data');
    }
  }

  Future<List<Makanan>> getKeyword(String keyword) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/makanan/?keyword=$keyword');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return makananFromListJson(response.body);
      default:
        throw Exception('Gagal mengambil data');
    }
  }

  Future<List<Makanan>> getByRestoran(String idRestoran) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/$idRestoran/makanan/');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return makananFromListJson(response.body);
      default:
        throw Exception('Gagal mengambil data');
    }
  }

  Future<Makanan> add(Makanan makanan, File gambar) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse(
        '${RPUrls.baseUrl}/v1/restoran/${makanan.restoran.pk}/makanan/');

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);

    request.fields['nama'] = makanan.nama;
    request.fields['harga'] = '${makanan.harga}';
    request.fields['deskripsi'] = makanan.deskripsi;
    request.files.add(await http.MultipartFile.fromPath('gambar', gambar.path));
    request.fields['kalori'] = '${makanan.kalori}';
    request.fields['kategori'] = makanan.kategori.join(',');

    var streamedResponse = await request.send();
    var body = await streamedResponse.stream.bytesToString();
    var response = http.Response(body, streamedResponse.statusCode,
        headers: streamedResponse.headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 201:
        return makananFromJson(response.body);
      case 401:
        throw Exception('User tidak terautentikasi');
      case 403:
        throw Exception('Tindakan tidak diizinkan');
      default:
        throw Exception('Error lainnya');
    }
  }

  Future<Makanan> edit(Makanan makanan, File? gambar) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/makanan/${makanan.pk}/');

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);

    request.fields['nama'] = makanan.nama;
    request.fields['harga'] = '${makanan.harga}';
    request.fields['deskripsi'] = makanan.deskripsi;
    if (gambar != null) {
      request.files
          .add(await http.MultipartFile.fromPath('gambar', gambar.path));
    }
    request.fields['kalori'] = '${makanan.kalori}';
    request.fields['kategori'] = makanan.kategori.join(',');

    var streamedResponse = await request.send();
    var body = await streamedResponse.stream.bytesToString();
    var response = http.Response(body, streamedResponse.statusCode,
        headers: streamedResponse.headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return makananFromJson(response.body);
      case 401:
        throw Exception('User tidak terautentikasi');
      case 403:
        throw Exception('Tindakan tidak diizinkan');
      case 404:
        throw Exception('Makanan tidak ditemukan');
      default:
        throw Exception('Error lainnya');
    }
  }

  Future<Makanan> delete(Makanan makanan) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/makanan/${makanan.pk}/');

    http.Response response = await client.delete(uri, headers: headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return makananFromJson(response.body);
      case 401:
        throw Exception('User tidak terautentikasi');
      case 403:
        throw Exception('Tindakan tidak diizinkan');
      case 404:
        throw Exception('Makanan tidak ditemukan');
      default:
        throw Exception('Error lainnya');
    }
  }

  Future<Map<String, String>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('${RPUrls.baseUrl}/v1/makanan/kategori/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body); // Decode respons JSON

      // Pastikan format JSON benar
      if (data is List) {
        // Jika respons berupa daftar
        return {for (var item in data) item['id']: item['nama']};
      } else if (data is Map) {
        // Jika respons berupa peta
        return Map<String, String>.from(data);
      } else {
        throw Exception("Format data tidak valid");
      }
    } else {
      throw Exception("Gagal memuat kategori, status: ${response.statusCode}");
    }
  }
}
