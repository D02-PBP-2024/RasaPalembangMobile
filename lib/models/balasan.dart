// To parse this JSON data, do
//
//     final balasan = balasanFromListJson(listJsonString);

import 'dart:convert';
import 'package:rasapalembang/models/user.dart';

List<Balasan> balasanFromListJson(String str) => List<Balasan>.from(json.decode(str).map((x) => Balasan.fromJson(x)));

class Balasan {
  String pk;
  String pesan;
  DateTime tanggalPosting;
  User user;
  String forum;

  Balasan({
    required this.pk,
    required this.pesan,
    required this.tanggalPosting,
    required this.user,
    required this.forum,
  });

  factory Balasan.fromJson(Map<String, dynamic> json) => Balasan(
    pk: json["pk"],
    pesan: json["fields"]["pesan"],
    tanggalPosting: DateTime.parse(json["fields"]["tanggal_posting"]),
    user: User.fromJson(json["fields"]["user"]),
    forum: json["fields"]["forum"],
  );
}
