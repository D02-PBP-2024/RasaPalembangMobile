// To parse this JSON data, do
//
//     final forum = forumFromJson(jsonString);

import 'dart:convert';

import 'package:rasapalembang/models/user.dart';

List<Forum> forumFromJson(String str) => List<Forum>.from(json.decode(str).map((x) => Forum.fromJson(x)));

String forumToJson(List<Forum> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forum {
    String pk;
    Fields fields;

    Forum({
        required this.pk,
        required this.fields,
    });

    factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String topik;
    String pesan;
    DateTime tanggalPosting;
    User user;
    String restoran;

    Fields({
        required this.topik,
        required this.pesan,
        required this.tanggalPosting,
        required this.user,
        required this.restoran,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        topik: json["topik"],
        pesan: json["pesan"],
        tanggalPosting: DateTime.parse(json["tanggal_posting"]),
        user: User.fromJson(json["user"]),
        restoran: json["restoran"],
    );

    Map<String, dynamic> toJson() => {
        "topik": topik,
        "pesan": pesan,
        "tanggal_posting": tanggalPosting.toIso8601String(),
        "user": user.toJson(),
        "restoran": restoran,
    };
}
