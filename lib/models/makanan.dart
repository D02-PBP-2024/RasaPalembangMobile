// To parse this JSON data, do
//
//     final makanan = makananFromJson(jsonString);

import 'dart:convert';

Makanan makananFromJson(String str) => Makanan.fromJson(json.decode(str));

String makananToJson(Makanan data) => json.encode(data.toJson());

class Makanan {
  String pk;
  Fields fields;

  Makanan({
    required this.pk,
    required this.fields,
  });

  factory Makanan.fromJson(Map<String, dynamic> json) => Makanan(
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  String nama;
  String deskripsi;
  String gambar;
  List<String> kategori;
  int kalori;
  int harga;
  String restoran;

  Fields({
    required this.nama,
    required this.deskripsi,
    required this.gambar,
    required this.kategori,
    required this.kalori,
    required this.harga,
    required this.restoran,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        gambar: json["gambar"],
        kategori: List<String>.from(json["kategori"]),
        kalori: json["kalori"],
        harga: json["harga"],
        restoran: json["restoran"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "harga": harga,
        "deskripsi": deskripsi,
        "gambar": gambar,
        "kalori": kalori,
        "kategori": kategori,
        "restoran": restoran,
      };
}