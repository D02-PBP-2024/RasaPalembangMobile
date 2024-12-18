// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

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
    username: json["username"],
    nama: json["nama"],
    deskripsi: json["deskripsi"],
    peran: json["peran"],
    foto: json["foto"],
    poin: json["poin"],
    dateJoined: DateTime.parse(json["date_joined"]),
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "username": username,
    "nama": nama,
    "deskripsi": deskripsi,
    "peran": peran,
    "foto": foto,
    "poin": poin,
    "date_joined": dateJoined.toIso8601String(),
  };
}
