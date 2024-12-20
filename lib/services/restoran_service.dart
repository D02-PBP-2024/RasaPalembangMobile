import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'dart:convert';

class RestoranService extends UserService {
  Future<List<Restoran>> get() async {
    await init();
    final uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return restoranFromListJson(response.body);
      default:
        throw Exception('Gagal mengambil data');
    }
  }

  Future<Restoran> add(Restoran restoran, File gambar) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/');

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);

    request.fields['nama'] = restoran.nama;
    request.fields['alamat'] = restoran.alamat;
    request.fields['jamBuka'] = restoran.jamBuka;
    request.fields['jamTutup'] = restoran.jamTutup;
    request.fields['nomorTelepon'] = restoran.nomorTelepon;
    request.files.add(await http.MultipartFile.fromPath('gambar', gambar.path));

    var streamedResponse = await request.send();
    var body = await streamedResponse.stream.bytesToString();
    var response = http.Response(body, streamedResponse.statusCode,
        headers: streamedResponse.headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return restoranFromJson(response.body);
      case 401:
        throw Exception('User tidak terautentikasi');
      case 403:
        throw Exception('Tindakan tidak diizinkan');
      default:
        throw Exception('Error lainnya');
    }
  }

  Future<Restoran> edit(Restoran restoran, File? gambar) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/${restoran.pk}/');

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);

    request.fields['nama'] = restoran.nama;
    request.fields['alamat'] = restoran.alamat;
    request.fields['jamBuka'] = restoran.jamBuka;
    request.fields['jamTutup'] = restoran.jamTutup;
    request.fields['nomorTelepon'] = restoran.nomorTelepon;
    if (gambar != null) {
      request.files.add(
        await http.MultipartFile.fromPath('gambar', gambar.path)
      );
    }

    var streamedResponse = await request.send();
    var body = await streamedResponse.stream.bytesToString();
    var response = http.Response(body, streamedResponse.statusCode,
        headers: streamedResponse.headers);
    await updateCookie(response);

    switch (response.statusCode) {
      case 200:
        return restoranFromJson(response.body);
      case 401:
        throw Exception('User tidak terautentikasi');
      case 403:
        throw Exception('Tindakan tidak diizinkan');
      default:
        throw Exception('Error lainnya');
    }
  }

  Future<void> delete(Restoran restoran) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/restoran/${restoran.pk}/');

    http.Response response =
      await client.delete(uri, headers: headers);
    await updateCookie(response);

    if (response.statusCode != 204) {
      throw Exception('Gagal menghapus restoran');
    }
  }
}