// To parse this JSON data, do
//
//     final forum = forumFromJson(jsonString);
//     final forumList = forumFromListJson(listJsonString);

import 'dart:convert';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/models/minuman.dart';

Favorit favoritFromJson(String str) => Favorit.fromJson(json.decode(str));
List<Favorit> favoritFromListJson(String str) => List<Favorit>.from(json.decode(str).map((x) => Favorit.fromJson(x)));

class Favorit {
  String pk;
  String catatan;
  int userId;
  Makanan? makanan;
  Minuman? minuman;
  Restoran? restoran;

  Favorit({
    required this.pk,
    required this.catatan,
    required this.userId,
    this.makanan,
    this.minuman,
    this.restoran,
  });

  factory Favorit.fromJson(Map<String, dynamic> json) => Favorit(
    pk: json["pk"],
    catatan: json["fields"]["catatan"],
    userId: json["fields"]["user"],
    makanan: json["fields"]["makanan"] != null ? Makanan.fromJson(json["fields"]["makanan"]) : null,
    minuman: json["fields"]["minuman"] != null ? Minuman.fromJson(json["fields"]["minuman"]) : null,
    restoran: json["fields"]["restoran"] != null ? Restoran.fromJson(json["fields"]["restoran"]) : null,
  );
}
