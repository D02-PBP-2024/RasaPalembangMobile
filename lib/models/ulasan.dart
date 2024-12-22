import 'dart:convert';

import 'package:rasapalembang/models/user.dart';

Ulasan ulasanFromJson(String str) => Ulasan.fromJson(json.decode(str));

List<Ulasan> ulasanFromListJson(String str) =>
    List<Ulasan>.from(json.decode(str).map((x) => Ulasan.fromJson(x)));

class Ulasan {
  String pk;
  DateTime createdAt;
  int nilai;
  String deskripsi;
  User user;
  String restoran;

  Ulasan({
    required this.pk,
    required this.createdAt,
    required this.nilai,
    required this.deskripsi,
    required this.user,
    required this.restoran,
  });

  factory Ulasan.fromJson(Map<String, dynamic> json) => Ulasan(
        pk: json["pk"],
        createdAt: DateTime.parse(json["fields"]["created_at"]),
        nilai: json["fields"]["nilai"],
        deskripsi: json["fields"]["deskripsi"],
        user: User.fromJson(json["fields"]["user"]),
        restoran: json["fields"]["restoran"],
      );
}
