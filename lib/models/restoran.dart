// To parse this JSON data, do
//
//     final restoran = restoranFromJson(jsonString);
//     final restoranList = restoranFromListJson(listJsonString);

import 'dart:convert';

Restoran restoranFromJson(String str) => Restoran.fromJson(json.decode(str));
List<Restoran> restoranFromListJson(String str) =>
    List<Restoran>.from(json.decode(str).map((x) => Restoran.fromJson(x)));

class Restoran {
  String pk;
  String nama;
  String alamat;
  String jamBuka;
  String jamTutup;
  String nomorTelepon;
  String gambar;
  String? user;
  double? rating;

  Restoran({
    required this.pk,
    required this.nama,
    required this.alamat,
    required this.jamBuka,
    required this.jamTutup,
    required this.nomorTelepon,
    required this.gambar,
    this.user,
    this.rating,
  });

  factory Restoran.fromJson(Map<String, dynamic> json) => Restoran(
        pk: json["pk"],
        nama: json["fields"]["nama"],
        alamat: json["fields"]["alamat"],
        jamBuka: json["fields"]["jam_buka"],
        jamTutup: json["fields"]["jam_tutup"],
        nomorTelepon: json["fields"]["nomor_telepon"],
        gambar: json["fields"]["gambar"],
        user: json["fields"]["user"],
        rating: json["fields"]["rating"],
      );
}
