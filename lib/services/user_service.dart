// pbp_django_auth
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show ChangeNotifier, kIsWeb;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rasapalembang/models/user.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class Cookie {
  String name;
  String value;
  int? expireTimestamp;

  Cookie(this.name, this.value, this.expireTimestamp);

  Cookie.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        value = json['value'],
        expireTimestamp = json['expireTimestamp'];

  Map toJson() => {
    'name': name,
    'value': value,
    'expireTimestamp': expireTimestamp,
  };
}

class UserService with ChangeNotifier {
  Map<String, String> headers = {};
  Map<String, Cookie> cookies = {};
  User? user;
  final http.Client client = http.Client();

  late SharedPreferences local;

  bool loggedIn = false;
  bool initialized = false;

  Future init() async {
    if (!initialized) {
      local = await SharedPreferences.getInstance();
      cookies = _loadSharedPrefs();
      if (cookies['sessionid'] != null) {
        loggedIn = true;
        await _loadUser();
        headers['cookie'] = _generateCookieHeader();
      }
    }
    initialized = true;
  }

  Map<String, Cookie> _loadSharedPrefs() {
    String? savedCookies = local.getString('cookies');
    if (savedCookies == null) {
      return {};
    }

    Map<String, Cookie> convCookies = {};

    try {
      var localCookies =
      Map<String, Map<String, dynamic>>.from(json.decode(savedCookies));
      for (String keyName in localCookies.keys) {
        convCookies[keyName] = Cookie.fromJson(localCookies[keyName]!);
      }
    } catch (_) {
      // We do not care if the cookie is invalid, just ignore it
    }

    return convCookies;
  }

  Future<void> saveUser(User user) async {
    this.user = user;

    String userJson = jsonEncode(user.toJson());

    await local.setString('user', userJson);
    notifyListeners();
  }

  Future<void> _loadUser() async {
    String? userJson = local.getString('user');
    if (userJson != null) {
      user = userFromJson(userJson);
      notifyListeners();
    }
  }

  Future persist(String cookies) async {
    local.setString('cookies', cookies);
  }

  Future updateCookie(http.Response response) async {
    await init();

    String? allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {
      // Hacky way to simply ignore expires
      allSetCookie = allSetCookie.replaceAll(
        RegExp(r'expires=.+?;', caseSensitive: false),
        '',
      );
      var setCookies = allSetCookie.split(',');

      for (var cookie in setCookies) {
        _setCookie(cookie);
      }

      headers['cookie'] = _generateCookieHeader();
      String cookieObject = (const JsonEncoder()).convert(cookies);
      persist(cookieObject);
    }
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.isEmpty) {
      return;
    }

    var cookieProps = rawCookie.split(';');

    // First part of cookie will always be the key-value pair
    var keyValue = cookieProps[0].split('=');
    if (keyValue.length != 2) {
      return;
    }

    String cookieName = keyValue[0].trim();
    String cookieValue = keyValue[1];

    int? cookieExpire;
    // Iterate through every props and find max-age
    // Expires works but Django always returns max-age, and according to MDN
    // max-age has higher prio

    for (var props in cookieProps.sublist(1)) {
      var keyval = props.split('=');
      if (keyval.length != 2) {
        continue;
      }

      var key = keyval[0].trim().toLowerCase();
      if (key != 'max-age') {
        continue;
      }

      int? deltaTime = int.tryParse(keyval[1]);
      if (deltaTime != null) {
        cookieExpire = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        cookieExpire += deltaTime;
      }
      break;
    }
    cookies[cookieName] = Cookie(cookieName, cookieValue, cookieExpire);
  }

  String _generateCookieHeader() {
    int currTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    String cookie = '';

    for (var key in cookies.keys) {
      if (cookie.isNotEmpty) cookie += ';';
      Cookie? curr = cookies[key];

      if (curr == null) continue;
      if (curr.expireTimestamp != null && currTime >= curr.expireTimestamp!) {
        if (curr.name == 'sessionid') {
          loggedIn = false;
          user = null;
          cookies = {};
          local.remove('user');
          local.remove('cookies');
          notifyListeners();
        }
        continue;
      }

      String newCookie = curr.value;
      cookie += '$key=$newCookie';
    }

    return cookie;
  }

  Future<User?> register(String nama, String username, String password1, String password2, String peran) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/register/');

    String data = jsonEncode({
      'nama': nama,
      'username': username,
      'password1': password1,
      'password2': password2,
      'peran': peran,
    });

    // Add additional header
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    http.Response response =
    await client.post(uri, body: data, headers: headers);

    // Remove used additional header
    headers.remove('Content-Type');
    await updateCookie(response);

    int code = response.statusCode;
    if (code == 201) {
      loggedIn = true;
      user = userFromJson(response.body);
      await saveUser(user!);
      return user;
    } else if (code == 400){
      loggedIn = false;
      throw Exception('Username sudah digunakan');
    } else {
      loggedIn = false;
      throw Exception('Request gagal!');
    }
  }

  Future<User?> login(String username, String password) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/login/');
    String data = jsonEncode({
      'username': username,
      'password': password,
    });

    // Add additional header
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    http.Response response =
    await client.post(uri, body: data, headers: headers);

    // Remove used additional header
    headers.remove('Content-Type');
    await updateCookie(response);

    int code = response.statusCode;
    if (code == 200) {
      loggedIn = true;
      user = userFromJson(response.body);
      await saveUser(user!);
      return user;
    } else if (code == 401) {
      loggedIn = false;
      throw Exception('Login gagal');
    } else {
      loggedIn = false;
      throw Exception('Request gagal!');
    }
  }

  Future<User?> logout() async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/logout/');

    http.Response response =
    await client.post(uri, headers: headers);

    int code = response.statusCode;
    if (code == 200) {
      loggedIn = false;
      cookies = {};
      user = null;
      await local.remove('user');
      await local.remove('cookies');
      notifyListeners();
      return userFromJson(response.body);
    } else if (code == 401) {
      throw Exception('User tidak terautentikasi');
    } else {
      throw Exception('Request gagal!');
    }
  }

  Future<User?> editProfile(String nama, String deskripsi, File? foto) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/profile/${user?.username}/');

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);

    request.fields['nama'] = nama;
    request.fields['deskripsi'] = deskripsi;

    if (foto != null) {
      request.files.add(
          await http.MultipartFile.fromPath('foto', foto.path)
      );
    }

    var streamedResponse = await request.send();
    var body = await streamedResponse.stream.bytesToString();
    var response = http.Response(body, streamedResponse.statusCode,
        headers: streamedResponse.headers);
    await updateCookie(response);

    int code = response.statusCode;
    if (code == 200) {
      user = userFromJson(response.body);
      return user;
    } else if (code == 404) {
      throw Exception('User tidak ditemukan');
    } else {
      throw Exception('Request gagal!');
    }
  }

  Future<User> getProfile(String username) async {
    await init();
    if (kIsWeb) {
      dynamic c = client;
      c.withCredentials = true;
    }

    final uri = Uri.parse('${RPUrls.baseUrl}/v1/profile/$username/');

    http.Response response = await client.get(uri, headers: headers);
    await updateCookie(response);

    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      throw Exception('Request gagal!');
    }
  }
}
