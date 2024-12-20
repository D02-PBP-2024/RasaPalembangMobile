// To parse this JSON data, do
//
//     final makanan = makananFromJson(jsonString);
//     final makananList = makananFromListJson(listJsonString);

import 'dart:convert';
import 'package:rasapalembang/models/restoran.dart';

Makanan makananFromJson(String str) => Makanan.fromJson(json.decode(str));
List<Makanan> makananFromListJson(String str) => List<Makanan>.from(json.decode(str).map((x) => Makanan.fromJson(x)));

class Makanan {
  String? pk;
  String nama;
  int harga;
  String deskripsi;
  String gambar;
  int kalori;
  Restoran restoran;
  List<String> kategori;

  Makanan({
    this.pk,
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
    kategori: List<String>.from(json["fields"]["kategori"].map((x) => x)),
    kalori: json["fields"]["kalori"],
    harga: json["fields"]["harga"],
    restoran: Restoran.fromJson(json["fields"]["restoran"]),
  );
}