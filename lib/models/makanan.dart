// To parse this JSON data, do
//
//     final makanan = makananFromJson(jsonString);
//     final makananList = makananFromListJson(listJsonString);

import 'dart:convert';
import 'package:rasapalembang/models/restoran.dart';

Makanan makananFromJson(String str) => Makanan.fromJson(json.decode(str));
List<Makanan> makananFromListJson(String str) => List<Makanan>.from(json.decode(str).map((x) => Makanan.fromJson(x)));

class Makanan {
  String pk;
  String nama;
  String deskripsi;
  String gambar;
  List<String> kategori;
  int kalori;
  int harga;
  Restoran restoran;

  Makanan({
    required this.pk,
    required this.nama,
    required this.deskripsi,
    required this.gambar,
    required this.kategori,
    required this.kalori,
    required this.harga,
    required this.restoran,
  });

  factory Makanan.fromJson(Map<String, dynamic> json) => Makanan(
    pk: json["pk"],
    nama: json["fields"]["nama"],
    deskripsi: json["fields"]["deskripsi"],
    gambar: json["fields"]["gambar"],
    kategori: List<String>.from(json["fields"]["kategori"]),
    kalori: json["fields"]["kalori"],
    harga: json["fields"]["harga"],
    restoran: Restoran.fromJson(json["fields"]["restoran"]),
  );
}
