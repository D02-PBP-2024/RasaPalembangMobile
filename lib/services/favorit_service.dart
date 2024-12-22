import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rasapalembang/models/favorit.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/services/restoran_service.dart';
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

    if (response.statusCode == 200) {
      return favoritFromJson(response.body);
    } else {
      throw Exception('Gagal mengambil data makanan');
    }
  }
  
  Future<bool> delete(String pk) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/favorit/delete/$pk/');

    http.Response response = await client.delete(uri, headers: headers);
    await updateCookie(response);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw false;
    }
  }

  Future<String?> add(String pk, String type) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/favorit/add/');

    // Prepare headers and body for JSON request
    final body = jsonEncode({
      'id': pk,
      'type': type,
    });

    try {
      http.Response response = await client.post(
        uri,
        headers: {
          ...headers,
          'Content-Type': 'application/json', // Ensure JSON content type
        },
        body: body,
      );

      await updateCookie(response);

      if (response.statusCode == 200) {
        // Parse the response body and return the "pk"
        final data = jsonDecode(response.body);
        return data['pk'];
      } else {
        debugPrint('Error: ${response.statusCode}, ${response.body}');
        return null; // Return null in case of an error
      }
    } catch (e) {
      debugPrint('Exception occurred: $e');
      return null; // Handle exceptions
    }
  }



  Future<bool> edit(String pk, String catatan) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/favorit/edit/$pk/');

    // Prepare headers and body for JSON request
    final body = jsonEncode({
      'catatan': catatan,
    });

    http.Response response = await client.put(
      uri,
      headers: {
        ...headers,
        'Content-Type': 'application/json', // Ensure JSON content type
      },
      body: body,
    );

    await updateCookie(response);

    int code = response.statusCode;
    if (code == 200) {
      return true; // Successfully updated
    } else {
      debugPrint('Error: ${response.statusCode}, ${response.body}');
      return false; // Update failed
    }
  }
}
