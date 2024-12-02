import 'dart:convert';

Ulasan ulasanFromJson(String str) => Ulasan.fromJson(json.decode(str));

String ulasanToJson(Ulasan data) => json.encode(data.toJson());

class Ulasan {
  String id;
  String createdAt;
  int nilai;
  String deskripsi;
  String user;
  String restoran;

  Ulasan({
    required this.id,
    required this.createdAt,
    required this.nilai,
    required this.deskripsi,
    required this.user,
    required this.restoran,
  });

  factory Ulasan.fromJson(Map<String, dynamic> json) => Ulasan(
        id: json["id"],
        createdAt: json["created_at"],
        nilai: json["nilai"],
        deskripsi: json["deskripsi"],
        user: json["user"],
        restoran: json["restoran"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "nilai": nilai,
        "deskripsi": deskripsi,
        "user": user,
        "restoran": restoran,
      };
}
