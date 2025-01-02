// To parse this JSON data, do
//
//     final minuman = minumanFromJson(jsonString);
//     final minumanList = minumanFromListJson(listJsonString);

import 'dart:convert';
import 'package:rasapalembang/models/restoran.dart';

Minuman minumanFromJson(String str) => Minuman.fromJson(json.decode(str));
List<Minuman> minumanFromListJson(String str) => List<Minuman>.from(json.decode(str).map((x) => Minuman.fromJson(x)));

class Minuman {
  String? pk;
  String? favorit;
  String nama;
  int harga;
  String deskripsi;
  String gambar;
  String ukuran;
  int tingkatKemanisan;
  Restoran restoran;

  Minuman({
    this.pk,
    this.favorit,
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.gambar,
    required this.ukuran,
    required this.tingkatKemanisan,
    required this.restoran,
  });

  factory Minuman.fromJson(Map<String, dynamic> json) => Minuman(
    pk: json["pk"],
    favorit: json["favorit"],
    nama: json["fields"]["nama"],
    harga: json["fields"]["harga"],
    deskripsi: json["fields"]["deskripsi"],
    gambar: json["fields"]["gambar"],
    ukuran: json["fields"]["ukuran"],
    tingkatKemanisan: json["fields"]["tingkat_kemanisan"],
    restoran: Restoran.fromJson(json["fields"]["restoran"]),
  );
}
