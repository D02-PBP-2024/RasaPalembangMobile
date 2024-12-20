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

    if (response.statusCode == 200) {
      return makananFromListJson(response.body);
    } else {
      throw Exception('Gagal mengambil data makanan');
    }
  }

  Future<Makanan> add(Makanan makanan, File gambar) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/${makanan.restoran.pk}/makanan/');

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
    var response = http.Response(body, streamedResponse.statusCode, headers: streamedResponse.headers);
    await updateCookie(response);

    int code = response.statusCode;
    if (code == 200) {
      return makananFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('User tidak terautentikasi');
    } else if (response.statusCode == 403) {
      throw Exception('Tindakan tidak diizinkan');
    } else {
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

    var request = http.MultipartRequest('PUT', uri);
    request.headers.addAll(headers);

    request.fields['nama'] = makanan.nama;
    request.fields['harga'] = '${makanan.harga}';
    request.fields['deskripsi'] = makanan.deskripsi;
    if (gambar != null) {
      request.files.add(
        await http.MultipartFile.fromPath('gambar', gambar.path)
      );
    }
    request.fields['kalori'] = '${makanan.kalori}';
    request.fields['kategori'] = makanan.kategori.join(',');

    var streamedResponse = await request.send();
    var body = await streamedResponse.stream.bytesToString();
    var response = http.Response(body, streamedResponse.statusCode, headers: streamedResponse.headers);
    await updateCookie(response);

    int code = response.statusCode;
    if (code == 200) {
      return makananFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('User tidak terautentikasi');
    } else if (response.statusCode == 403) {
      throw Exception('Tindakan tidak diizinkan');
    } else {
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

    int code = response.statusCode;
    if (code == 200) {
      return makananFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('User tidak terautentikasi');
    } else if (response.statusCode == 403) {
      throw Exception('Tindakan tidak diizinkan');
    } else {
      throw Exception('Error lainnya');
    }
  }

  Future<List<String>> fetchCategories() async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/makanan/');
    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Periksa apakah `kategori` tersedia dalam respons
      if (data.containsKey('kategori') && data['kategori'] is List) {
        return List<String>.from(data['kategori']);
      } else {
        throw Exception('Data kategori tidak ditemukan di respons.');
      }
    } else {
      throw Exception('Gagal mengambil data kategori');
    }
  }
}