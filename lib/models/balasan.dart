// To parse this JSON data, do
//
//     final balasan = balasanFromJson(jsonString);

import 'dart:convert';

import 'package:rasapalembang/models/user.dart';

List<Balasan> balasanFromJson(String str) =>
    List<Balasan>.from(json.decode(str).map((x) => Balasan.fromJson(x)));

String balasanToJson(List<Balasan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Balasan {
  String pk;
  Fields fields;

  Balasan({
    required this.pk,
    required this.fields,
  });

  factory Balasan.fromJson(Map<String, dynamic> json) => Balasan(
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String pesan;
  DateTime tanggalPosting;
  User user;
  String forum;

  Fields({
    required this.pesan,
    required this.tanggalPosting,
    required this.user,
    required this.forum,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        pesan: json["pesan"],
        tanggalPosting: DateTime.parse(json["tanggal_posting"]),
        user: User.fromJson(json["user"]),
        forum: json["forum"],
      );

  Map<String, dynamic> toJson() => {
        "pesan": pesan,
        "tanggal_posting": tanggalPosting.toIso8601String(),
        "user": user.toJson(),
        "forum": forum,
      };
}
