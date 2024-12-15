import 'dart:convert';

Favorit favoritFromJson(String str) => Favorit.fromJson(json.decode(str));

String favoritToJson(Favorit data) => json.encode(data.toJson());

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
  String makanan;
  String minuman;
  String restoran;

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
        makanan: json["makanan"],
        minuman: json["minuman"],
        restoran: json["restoran"],
      );

  Map<String, dynamic> toJson() => {
        "catatan": catatan,
        "user": user,
        "makanan": makanan,
        "minuman": minuman,
        "restoran": restoran,
      };
}