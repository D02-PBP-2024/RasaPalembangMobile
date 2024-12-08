// To parse this JSON data, do
//
//     final minuman = minumanFromJson(jsonString);

import 'dart:convert';

Minuman minumanFromJson(String str) => Minuman.fromJson(json.decode(str));

String minumanToJson(Minuman data) => json.encode(data.toJson());

class Minuman {
  String pk;
  Fields fields;

  Minuman({
    required this.pk,
    required this.fields,
  });

  factory Minuman.fromJson(Map<String, dynamic> json) => Minuman(
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
  int harga;
  String deskripsi;
  String gambar;
  String ukuran;
  int tingkatKemanisan;
  String restoran;

  Fields({
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.gambar,
    required this.ukuran,
    required this.tingkatKemanisan,
    required this.restoran,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    nama: json["nama"],
    harga: json["harga"],
    deskripsi: json["deskripsi"],
    gambar: json["gambar"],
    ukuran: json["ukuran"],
    tingkatKemanisan: json["tingkat_kemanisan"],
    restoran: json["restoran"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "harga": harga,
    "deskripsi": deskripsi,
    "gambar": gambar,
    "ukuran": ukuran,
    "tingkat_kemanisan": tingkatKemanisan,
    "restoran": restoran,
  };
}
