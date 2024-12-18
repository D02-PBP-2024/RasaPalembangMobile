// To parse this JSON data, do
//
//     final makanan = makananFromJson(jsonString);

import 'dart:convert';

List<Makanan> makananFromJson(String str) => List<Makanan>.from(json.decode(str).map((x) => Makanan.fromJson(x)));

String makananToJson(List<Makanan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Makanan {
  String pk;
  MakananFields fields;

  Makanan({
    required this.pk,
    required this.fields,
  });

  factory Makanan.fromJson(Map<String, dynamic> json) => Makanan(
    pk: json["pk"],
    fields: MakananFields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class MakananFields {
  String nama;
  int harga;
  String deskripsi;
  String gambar;
  int kalori;
  String restoran;
  List<String> kategori;

  MakananFields({
    required this.nama,
    required this.deskripsi,
    required this.gambar,
    required this.kategori,
    required this.kalori,
    required this.harga,
    required this.restoran,
  });

  factory MakananFields.fromJson(Map<String, dynamic> json) => MakananFields(
    nama: json["nama"],
    deskripsi: json["deskripsi"],
    gambar: json["gambar"],
    kategori: List<String>.from(json["kategori"].map((x) => x)),
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
    "kategori": List<dynamic>.from(kategori.map((x) => x)),
    "restoran": restoran,
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