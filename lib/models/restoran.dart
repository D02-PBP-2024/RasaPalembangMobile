// To parse this JSON data, do
//
//     final restoran = restoranFromJson(jsonString);

import 'dart:convert';

Restoran restoranFromJson(String str) => Restoran.fromJson(json.decode(str));

String restoranToJson(Restoran data) => json.encode(data.toJson());

class Restoran {
  String id;
  String nama;
  String alamat;
  String jamBuka; // Format waktu sebagai string (e.g., "08:00")
  String jamTutup; // Format waktu sebagai string (e.g., "22:00")
  String? nomorTelepon;
  String? gambar;
  String user;

  Restoran({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.jamBuka,
    required this.jamTutup,
    this.nomorTelepon,
    this.gambar,
    required this.user,
  });

  factory Restoran.fromJson(Map<String, dynamic> json) => Restoran(
        id: json["id"],
        nama: json["nama"],
        alamat: json["alamat"],
        jamBuka: json["jam_buka"],
        jamTutup: json["jam_tutup"],
        nomorTelepon: json["nomor_telepon"],
        gambar: json["gambar"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "alamat": alamat,
        "jam_buka": jamBuka,
        "jam_tutup": jamTutup,
        "nomor_telepon": nomorTelepon,
        "gambar": gambar,
        "user": user,
      };
}
