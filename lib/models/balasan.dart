// To parse this JSON data, do
//
//     final balasan = balasanFromJson(jsonString);

import 'dart:convert';

List<Balasan> balasanFromJson(String str) => List<Balasan>.from(json.decode(str).map((x) => Balasan.fromJson(x)));

String balasanToJson(List<Balasan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Balasan {
    String model;
    String pk;
    Fields fields;

    Balasan({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Balasan.fromJson(Map<String, dynamic> json) => Balasan(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String pesan;
    DateTime tanggalPosting;
    int user;
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
        user: json["user"],
        forum: json["forum"],
    );

    Map<String, dynamic> toJson() => {
        "pesan": pesan,
        "tanggal_posting": tanggalPosting.toIso8601String(),
        "user": user,
        "forum": forum,
    };
}
