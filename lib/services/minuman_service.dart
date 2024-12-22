import 'dart:io';
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

    switch (response.statusCode) {
      case 200:
        return minumanFromListJson(response.body);
      default:
        throw Exception('Gagal mengambil data');
    }
  }

  Future<List<Minuman>> getKeyword(String keyword) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/minuman/?keyword=$keyword');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return minumanFromListJson(response.body);
      default:
        throw Exception('Gagal mengambil data');
    }
  }

  Future<List<Minuman>> getByRestoran(String idRestoran) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/$idRestoran/minuman/');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    if (response.statusCode == 200) {
      return minumanFromListJson(response.body);
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  Future<Minuman> add(Minuman minuman, File gambar) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/${minuman.restoran.pk}/minuman/');

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);

    request.fields['nama'] = minuman.nama;
    request.fields['harga'] = '${minuman.harga}';
    request.fields['deskripsi'] = minuman.deskripsi;
    request.files.add(await http.MultipartFile.fromPath('gambar', gambar.path));
    request.fields['ukuran'] = minuman.ukuran;
    request.fields['tingkat_kemanisan'] = '${minuman.tingkatKemanisan}';

    var streamedResponse = await request.send();
    var body = await streamedResponse.stream.bytesToString();
    var response = http.Response(body, streamedResponse.statusCode,
        headers: streamedResponse.headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 201:
        return minumanFromJson(response.body);
      case 401:
        throw Exception('User tidak terautentikasi');
      case 403:
        throw Exception('Tindakan tidak diizinkan');
      default:
        throw Exception('Error lainnya');
    }
  }

  Future<Minuman> edit(Minuman minuman, File? gambar) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/minuman/${minuman.pk}/');

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);

    request.fields['nama'] = minuman.nama;
    request.fields['harga'] = '${minuman.harga}';
    request.fields['deskripsi'] = minuman.deskripsi;
    if (gambar != null) {
      request.files.add(
        await http.MultipartFile.fromPath('gambar', gambar.path)
      );
    }
    request.fields['ukuran'] = minuman.ukuran;
    request.fields['tingkat_kemanisan'] = '${minuman.tingkatKemanisan}';

    var streamedResponse = await request.send();
    var body = await streamedResponse.stream.bytesToString();
    var response = http.Response(body, streamedResponse.statusCode,
        headers: streamedResponse.headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return minumanFromJson(response.body);
      case 401:
        throw Exception('User tidak terautentikasi');
      case 403:
        throw Exception('Tindakan tidak diizinkan');
      case 404:
        throw Exception('Minuman tidak ditemukan');
      default:
        throw Exception('Error lainnya');
    }
  }

  Future<Minuman> delete(Minuman minuman) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/minuman/${minuman.pk}/');

    http.Response response =
      await client.delete(uri, headers: headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return minumanFromJson(response.body);
      case 401:
        throw Exception('User tidak terautentikasi');
      case 403:
        throw Exception('Tindakan tidak diizinkan');
      case 404:
        throw Exception('Minuman tidak ditemukan');
      default:
        throw Exception('Error lainnya');
    }
  }
}
