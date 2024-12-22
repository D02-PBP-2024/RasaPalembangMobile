// To parse this JSON data, do
//
//     final favorit = favoritFromJson(jsonString);

import 'dart:convert';

List<Favorit> favoritFromJson(String str) => List<Favorit>.from(json.decode(str).map((x) => Favorit.fromJson(x)));

String favoritToJson(List<Favorit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favorit {
    String pk;
    Fields fields;

    Favorit({
        required this.pk,
        required this.fields,
    });

    factory Favorit.fromJson(Map<String, dynamic> json) => Favorit(
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String catatan;
    int user;
    Detail? makanan;
    Detail? minuman;
    Detail? restoran;

    Fields({
        required this.catatan,
        required this.user,
        required this.makanan,
        required this.minuman,
        required this.restoran,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        catatan: json["catatan"],
        user: json["user"],
        makanan: json["makanan"] == null ? null : Detail.fromJson(json["makanan"]),
        minuman: json["minuman"] == null ? null : Detail.fromJson(json["minuman"]),
        restoran: json["restoran"] == null ? null : Detail.fromJson(json["restoran"]),
    );

    Map<String, dynamic> toJson() => {
        "catatan": catatan,
        "user": user,
        "makanan": makanan?.toJson(),
        "minuman": minuman?.toJson(),
        "restoran": restoran?.toJson(),
    };
}

class Detail {
    String pk;
    String nama;
    String gambar;

    Detail({
        required this.pk,
        required this.nama,
        required this.gambar,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        pk: json["pk"],
        nama: json["nama"],
        gambar: json["gambar"],
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "nama": nama,
        "gambar": gambar,
    };
}
