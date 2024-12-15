// To parse this JSON data, do
//
//     final minuman = minumanFromJson(jsonString);

import 'dart:convert';

List<Minuman> minumanFromJson(String str) => List<Minuman>.from(json.decode(str).map((x) => Minuman.fromJson(x)));

String minumanToJson(List<Minuman> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Minuman {
  String pk;
  MinumanFields fields;

  Minuman({
    required this.pk,
    required this.fields,
  });

  factory Minuman.fromJson(Map<String, dynamic> json) => Minuman(
    pk: json["pk"],
    fields: MinumanFields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class MinumanFields {
  String nama;
  int harga;
  String deskripsi;
  String gambar;
  String ukuran;
  int tingkatKemanisan;
  Restoran restoran;

  MinumanFields({
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.gambar,
    required this.ukuran,
    required this.tingkatKemanisan,
    required this.restoran,
  });

  factory MinumanFields.fromJson(Map<String, dynamic> json) => MinumanFields(
    nama: json["nama"],
    harga: json["harga"],
    deskripsi: json["deskripsi"],
    gambar: json["gambar"],
    ukuran: json["ukuran"],
    tingkatKemanisan: json["tingkat_kemanisan"],
    restoran: Restoran.fromJson(json["restoran"]),
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "harga": harga,
    "deskripsi": deskripsi,
    "gambar": gambar,
    "ukuran": ukuran,
    "tingkat_kemanisan": tingkatKemanisan,
    "restoran": restoran.toJson(),
  };
}

class Restoran {
  String pk;
  RestoranFields fields;

  Restoran({
    required this.pk,
    required this.fields,
  });

  factory Restoran.fromJson(Map<String, dynamic> json) => Restoran(
    pk: json["pk"],
    fields: RestoranFields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class RestoranFields {
  String nama;
  String alamat;
  String jamBuka;
  String jamTutup;
  String nomorTelepon;
  String gambar;
  String user;

  RestoranFields({
    required this.nama,
    required this.alamat,
    required this.jamBuka,
    required this.jamTutup,
    required this.nomorTelepon,
    required this.gambar,
    required this.user,
  });

  factory RestoranFields.fromJson(Map<String, dynamic> json) => RestoranFields(
    nama: json["nama"],
    alamat: json["alamat"],
    jamBuka: json["jam_buka"],
    jamTutup: json["jam_tutup"],
    nomorTelepon: json["nomor_telepon"],
    gambar: json["gambar"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "alamat": alamat,
    "jam_buka": jamBuka,
    "jam_tutup": jamTutup,
    "nomor_telepon": nomorTelepon,
    "gambar": gambar,
    "user": user,
  };
}
