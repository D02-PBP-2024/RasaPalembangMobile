// To parse this JSON data, do
//
//     final restoran = restoranFromJson(jsonString);

import 'dart:convert';

Restoran restoranFromJson(String str) => Restoran.fromJson(json.decode(str));

String restoranToJson(Restoran data) => json.encode(data.toJson());

class Restoran {
    String model;
    String pk;
    Fields fields;

    Restoran({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Restoran.fromJson(Map<String, dynamic> json) => Restoran(
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
    String nama;
    String alamat;
    String jamBuka;
    String jamTutup;
    String nomorTelepon;
    String gambar;
    int user;

    Fields({
        required this.nama,
        required this.alamat,
        required this.jamBuka,
        required this.jamTutup,
        required this.nomorTelepon,
        required this.gambar,
        required this.user,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
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
