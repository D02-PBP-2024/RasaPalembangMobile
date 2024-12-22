// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  int pk;
  String username;
  String nama;
  String deskripsi;
  String peran;
  String foto;
  int poin;
  DateTime dateJoined;

  User({
    required this.pk,
    required this.username,
    required this.nama,
    required this.deskripsi,
    required this.peran,
    required this.foto,
    required this.poin,
    required this.dateJoined,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    pk: json["pk"],
    username: json["fields"]["username"],
    nama: json["fields"]["nama"],
    deskripsi: json["fields"]["deskripsi"],
    peran: json["fields"]["peran"],
    foto: json["fields"]["foto"],
    poin: json["fields"]["poin"],
    dateJoined: DateTime.parse(json["fields"]["date_joined"]),
  );
}
