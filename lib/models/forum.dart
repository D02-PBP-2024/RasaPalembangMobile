// To parse this JSON data, do
//
//     final forum = forumFromJson(jsonString);
//     final forumList = forumFromListJson(listJsonString);

import 'dart:convert';

import 'package:rasapalembang/models/user.dart';

Forum forumFromJson(String str) => Forum.fromJson(json.decode(str));
List<Forum> forumFromListJson(String str) =>
    List<Forum>.from(json.decode(str).map((x) => Forum.fromJson(x)));

class Forum {
  String pk;
  String topik;
  String pesan;
  DateTime tanggalPosting;
  User user;
  String restoran;

  Forum({
    required this.pk,
    required this.topik,
    required this.pesan,
    required this.tanggalPosting,
    required this.user,
    required this.restoran,
  });

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        pk: json["pk"],
        topik: json["fields"]["topik"],
        pesan: json["fields"]["pesan"],
        tanggalPosting: DateTime.parse(json["fields"]["tanggal_posting"]),
        user: User.fromJson(json["fields"]["user"]),
        restoran: json["fields"]["restoran"],
      );
}
